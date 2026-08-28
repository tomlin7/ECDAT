"use client";

import type { ReactNode } from "react";
import {
  ChevronDown,
  LayoutDashboard,
  LineChart,
  Megaphone,
  Monitor,
  Play,
  Radar,
  Radio,
  Search,
  Settings,
  Sparkles,
  Upload,
} from "lucide-react";
import { cn } from "@/lib/utils";

export type AppView = "discover" | "ingest" | "corpus" | "inventory";

const ICON_NAV = [
  { id: "discover" as const, icon: Radar, label: "Discover" },
  { id: "ingest" as const, icon: Upload, label: "Ingest" },
  { id: "corpus" as const, icon: LayoutDashboard, label: "Corpus" },
  { id: "inventory" as const, icon: LineChart, label: "Inventory" },
];

export function AppShell({
  view,
  onView,
  secondaryTitle,
  secondaryItems,
  secondaryActive,
  onSecondarySelect,
  breadcrumb,
  actions,
  children,
}: {
  view: AppView;
  onView: (v: AppView) => void;
  secondaryTitle: string;
  secondaryItems: { id: string; label: string }[];
  secondaryActive: string;
  onSecondarySelect: (id: string) => void;
  breadcrumb: ReactNode;
  actions?: ReactNode;
  children: ReactNode;
}) {
  return (
    <div className="flex h-screen min-h-0 bg-[#1c1c22] text-[#f0edf6]">
      <aside className="flex w-[56px] shrink-0 flex-col items-center border-r border-[#2a2a32] bg-[#121217] py-2">
        <div className="mb-3 flex size-9 items-center justify-center">
          <div className="flex size-8 items-center justify-center rounded-md bg-[#6c5fc7] text-[11px] font-bold text-white">
            E
          </div>
        </div>
        <nav className="flex flex-col gap-0.5">
          {ICON_NAV.map(({ id, icon: Icon, label }) => (
            <button
              key={id}
              type="button"
              title={label}
              onClick={() => onView(id)}
              className={cn(
                "flex size-10 items-center justify-center rounded-lg transition-colors",
                view === id
                  ? "bg-[#6c5fc7] text-white"
                  : "text-[#8b8794] hover:bg-[#1c1c22] hover:text-[#f0edf6]",
              )}
            >
              <Icon className="size-[18px]" strokeWidth={1.5} />
            </button>
          ))}
        </nav>
        <div className="mt-auto flex flex-col gap-1 pb-2">
          <button
            type="button"
            className="flex size-10 items-center justify-center rounded-lg text-[#8b8794] hover:bg-[#1c1c22] hover:text-[#f0edf6]"
            title="Monitors"
          >
            <Monitor className="size-[18px]" strokeWidth={1.5} />
          </button>
          <button
            type="button"
            className="flex size-10 items-center justify-center rounded-lg text-[#8b8794] hover:bg-[#1c1c22] hover:text-[#f0edf6]"
            title="Settings"
          >
            <Settings className="size-[18px]" strokeWidth={1.5} />
          </button>
          <div className="mx-auto mt-1 flex size-8 items-center justify-center rounded-full bg-[#6c5fc7] text-[10px] font-semibold text-white">
            EC
          </div>
        </div>
      </aside>

      <aside className="flex w-[200px] shrink-0 flex-col border-r border-[#2a2a32] bg-[#121217]">
        <div className="px-4 pt-4 pb-2">
          <p className="text-[11px] font-semibold tracking-[0.06em] text-[#8b8794] uppercase">
            {secondaryTitle}
          </p>
        </div>
        <nav className="flex flex-col gap-0.5 px-2">
          {secondaryItems.map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => onSecondarySelect(item.id)}
              className={cn(
                "rounded-lg px-3 py-2 text-left text-[13px] transition-colors",
                secondaryActive === item.id
                  ? "bg-[#6c5fc7] font-medium text-white"
                  : "text-[#c4c1d2] hover:bg-[#1c1c22] hover:text-white",
              )}
            >
              {item.label}
            </button>
          ))}
        </nav>
        <div className="mt-auto border-t border-[#2a2a32] p-3">
          <p className="text-[11px] font-semibold tracking-[0.06em] text-[#8b8794] uppercase">
            Export
          </p>
          <button
            type="button"
            className="mt-2 w-full rounded-lg px-3 py-2 text-left text-[13px] text-[#c4c1d2] hover:bg-[#1c1c22]"
          >
            Inventory report
          </button>
        </div>
      </aside>

      <div className="flex min-w-0 flex-1 flex-col">
        <header className="shrink-0 border-b border-[#2a2a32] bg-[#1c1c22] px-4 py-2.5">
          <div className="flex flex-wrap items-center gap-2">
            <div className="mr-2 text-[13px] text-[#c4c1d2]">{breadcrumb}</div>
            <FilterDropdown label="llvm-ir" />
            <FilterDropdown label="All artifacts" />
            <FilterDropdown label="14D" />
            <div className="flex min-w-[180px] flex-1 items-center gap-2 rounded-[6px] border border-[#3a3a46] border-b-[3px] border-b-[#121218] bg-[#2a2a32] px-3 py-1.5">
              <Search className="size-3.5 shrink-0 text-[#8b8794]" />
              <span className="rounded-md bg-[#3d3560] px-2 py-0.5 text-[12px] text-[#e2d9ff]">
                is unresolved
              </span>
              <input
                className="min-w-0 flex-1 bg-transparent text-[13px] text-[#f0edf6] outline-none placeholder:text-[#8b8794]"
                placeholder="Search findings…"
                readOnly
              />
            </div>
            <div className="ml-auto flex items-center gap-2">
              <button type="button" className="btn-tactile-icon" title="Replay demo">
                <Play className="size-3.5" />
              </button>
              <button type="button" className="btn-tactile h-8 px-2.5">
                <Sparkles className="size-3.5 text-[#a78bfa]" />
                Ask ECDAT
              </button>
              <button type="button" className="btn-tactile-icon" title="Search">
                <Search className="size-3.5" />
              </button>
              <button
                type="button"
                className="inline-flex size-8 items-center justify-center text-[#c4c1d2] hover:text-white"
                title="Announcements"
              >
                <Megaphone className="size-4" />
              </button>
              <button type="button" className="btn-tactile h-8 min-w-[140px] justify-between px-2.5">
                <span>Recommended</span>
                <span className="flex items-center gap-1.5">
                  <span className="flex size-5 items-center justify-center rounded bg-[#2d8f4e] text-white">
                    <Radio className="size-3" />
                  </span>
                  <ChevronDown className="size-3.5 text-[#8b8794]" />
                </span>
              </button>
              {actions}
            </div>
          </div>
        </header>

        <main className="min-h-0 flex-1 overflow-auto bg-[#1c1c22] p-4">
          {children}
        </main>
      </div>
    </div>
  );
}

function FilterDropdown({ label }: { label: string }) {
  return (
    <button type="button" className="btn-tactile h-8 px-2.5">
      {label}
      <ChevronDown className="size-3.5 text-[#8b8794]" />
    </button>
  );
}

export function WorkbenchPanel({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div className={cn("rounded-xl bg-[#2b2540] p-5", className)}>{children}</div>
  );
}

export function SetupCard({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  return (
    <div
      className={cn(
        "rounded-xl border border-[#34343f] bg-[#24242c] p-6",
        className,
      )}
    >
      {children}
    </div>
  );
}

export function PreviewCard({ children }: { children: ReactNode }) {
  return (
    <div className="overflow-hidden rounded-xl border border-[#e0e0e6] bg-white text-[#1c1c22] shadow-sm">
      {children}
    </div>
  );
}

export function StepCircle({
  n,
  active,
}: {
  n: number;
  active?: boolean;
}) {
  return (
    <span
      className={cn(
        "flex size-7 shrink-0 items-center justify-center rounded-full text-[13px] font-semibold",
        active
          ? "bg-[#6c5fc7] text-white"
          : "border border-[#4a4a55] bg-[#1c1c22] text-[#8b8794]",
      )}
    >
      {n}
    </span>
  );
}
