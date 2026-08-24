export type LogRegModel = {
  version: string;
  labels: string[];
  featureNames: string[];
  weights: number[][];
  bias: number[];
  trainAccuracy: number;
  holdoutAccuracy: number;
  trainedOn: number;
};

export function softmax(logits: number[]): number[] {
  const m = Math.max(...logits);
  const exps = logits.map((z) => Math.exp(z - m));
  const s = exps.reduce((a, b) => a + b, 0);
  return exps.map((e) => e / s);
}

export function predictLogReg(
  x: number[],
  model: LogRegModel,
): { label: string; confidence: number; scores: Record<string, number> } {
  const logits = model.labels.map((_, k) => {
    let z = model.bias[k] ?? 0;
    const w = model.weights[k] ?? [];
    for (let i = 0; i < x.length; i++) z += (w[i] ?? 0) * x[i];
    return z;
  });
  const p = softmax(logits);
  let best = 0;
  for (let i = 1; i < p.length; i++) if (p[i] > p[best]) best = i;
  const scores: Record<string, number> = {};
  model.labels.forEach((lab, i) => {
    scores[lab] = Math.round(p[i] * 1000) / 1000;
  });
  return {
    label: model.labels[best],
    confidence: Math.round(p[best] * 1000) / 1000,
    scores,
  };
}

export function trainLogReg(
  xs: number[][],
  ys: number[],
  labels: string[],
  featureNames: string[],
): LogRegModel {
  const n = xs.length;
  const d = xs[0]?.length ?? 0;
  const k = labels.length;
  const weights = Array.from({ length: k }, () => Array(d).fill(0));
  const bias = Array(k).fill(0);
  const lr = 0.35;
  const l2 = 0.004;
  const epochs = 500;

  for (let ep = 0; ep < epochs; ep++) {
    const gW = Array.from({ length: k }, () => Array(d).fill(0));
    const gB = Array(k).fill(0);
    for (let i = 0; i < n; i++) {
      const x = xs[i];
      const logits = weights.map((w, c) => {
        let z = bias[c];
        for (let j = 0; j < d; j++) z += w[j] * x[j];
        return z;
      });
      const p = softmax(logits);
      for (let c = 0; c < k; c++) {
        const err = p[c] - (ys[i] === c ? 1 : 0);
        gB[c] += err;
        for (let j = 0; j < d; j++) gW[c][j] += err * x[j];
      }
    }
    for (let c = 0; c < k; c++) {
      bias[c] -= (lr * gB[c]) / n;
      for (let j = 0; j < d; j++) {
        weights[c][j] -= (lr * (gW[c][j] / n + l2 * weights[c][j]));
      }
    }
  }

  const acc = (idx: number[]) => {
    let ok = 0;
    for (const i of idx) {
      const pred = predictLogReg(xs[i], {
        version: "tmp",
        labels,
        featureNames,
        weights,
        bias,
        trainAccuracy: 0,
        holdoutAccuracy: 0,
        trainedOn: n,
      });
      if (pred.label === labels[ys[i]]) ok += 1;
    }
    return idx.length ? ok / idx.length : 0;
  };

  const all = xs.map((_, i) => i);
  const hold = all.filter((_, i) => i % 5 === 0);
  const trainIdx = all.filter((_, i) => i % 5 !== 0);
  return {
    version: "ecdat-logreg-v1",
    labels,
    featureNames,
    weights,
    bias,
    trainAccuracy: Math.round(acc(trainIdx) * 1000) / 1000,
    holdoutAccuracy: Math.round(acc(hold) * 1000) / 1000,
    trainedOn: n,
  };
}
