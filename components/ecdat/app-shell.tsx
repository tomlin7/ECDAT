"use client";

import type { ReactNode } from "react";
import {
  BookOpen,
  Database,
  FileStack,
  Radar,
  Shield,
  Upload,
} from "lucide-react";
import { cn } from "@/lib/utils";

export type AppView = "discover" | "ingest" | "corpus" | "inventory";

const NAV: { id: AppView; label: string; icon: typeof Radar }[] = [
  { id: "discover", label: "Discover", icon: Radar },
  { id: "ingest", label: "Ingest", icon: Upload },
  { id: "corpus", label: "Corpus", icon: Database },
  { id: "inventory", label: "Inventory", icon: FileStack },
];

export function AppShell({
  view,
  onView,
  topbar,
  sidebar,
  children,
}: {
  view: AppView;
  onView: (v: AppView) => void;
  topbar: ReactNode;
  sidebar?: ReactNode;
  children: ReactNode;
}) {
  return (
    <div className="flex h-screen min-h-0 bg-background">
      {/* Primary icon rail */}
      <aside className="flex w-14 shrink-0 flex-col items-center border-r border-border bg-[#12121a] py-3">
        <div className="mb-4 flex size-9 items-center justify-center rounded-md bg-primary/20 text-primary">
          <Shield className="size-5" />
        </div>
        <nav className="flex flex-1 flex-col gap-1">
          {NAV.map(({ id, label, icon: Icon }) => (
            <button
              key={id}
              type="button"
              title={label}
              onClick={() => onView(id)}
              className={cn(
                "flex size-10 items-center justify-center rounded-md transition-colors",
                view === id
                  ? "bg-primary/20 text-primary"
                  : "text-muted-foreground hover:bg-[#1e1e29] hover:text-foreground",
              )}
            >
              <Icon className="size-[18px]" strokeWidth={1.75} />
            </button>
          ))}
        </nav>
        <a
          href="/pitch/sih-deck.html"
          target="_blank"
          rel="noreferrer"
          title="Pitch deck"
          className="mt-auto flex size-10 items-center justify-center rounded-md text-muted-foreground transition-colors hover:bg-[#1e1e29] hover:text-foreground"
        >
          <BookOpen className="size-[18px]" strokeWidth={1.75} />
        </a>
      </aside>

      {/* Secondary sidebar */}
      {sidebar ? (
        <aside className="flex w-56 shrink-0 flex-col border-r border-border bg-[#12121a]">
          {sidebar}
        </aside>
      ) : null}

      {/* Main */}
      <div className="flex min-w-0 flex-1 flex-col">
        {topbar}
        <main className="min-h-0 flex-1 overflow-auto bg-background">
          {children}
        </main>
      </div>
    </div>
  );
}

export function SecondaryNav({
  title,
  items,
  active,
  onSelect,
}: {
  title: string;
  items: { id: string; label: string; count?: number }[];
  active: string;
  onSelect: (id: string) => void;
}) {
  return (
    <>
      <div className="border-b border-border px-4 py-3">
        <p className="text-[11px] font-semibold tracking-wider text-muted-foreground uppercase">
          {title}
        </p>
      </div>
      <nav className="flex flex-col gap-0.5 p-2">
        {items.map((item) => (
          <button
            key={item.id}
            type="button"
            onClick={() => onSelect(item.id)}
            className={cn(
              "flex items-center justify-between rounded-md px-3 py-2 text-left text-[13px] transition-colors",
              active === item.id
                ? "bg-primary/15 font-medium text-foreground"
                : "text-muted-foreground hover:bg-[#1e1e29] hover:text-foreground",
            )}
          >
            <span>{item.label}</span>
            {item.count != null ? (
              <span className="font-mono text-[11px] text-muted-foreground">
                {item.count}
              </span>
            ) : null}
          </button>
        ))}
      </nav>
    </>
  );
}

export function TopBar({
  title,
  subtitle,
  actions,
  filters,
}: {
  title: string;
  subtitle?: string;
  actions?: ReactNode;
  filters?: ReactNode;
}) {
  return (
    <header className="shrink-0 border-b border-border bg-[#1e1e29]">
      <div className="flex flex-wrap items-center justify-between gap-3 px-5 py-3">
        <div className="min-w-0">
          <h1 className="truncate text-[15px] font-semibold text-foreground">
            {title}
          </h1>
          {subtitle ? (
            <p className="truncate text-[12px] text-muted-foreground">
              {subtitle}
            </p>
          ) : null}
        </div>
        {actions ? (
          <div className="flex flex-wrap items-center gap-2">{actions}</div>
        ) : null}
      </div>
      {filters ? (
        <div className="flex flex-wrap items-center gap-2 border-t border-border px-5 py-2">
          {filters}
        </div>
      ) : null}
    </header>
  );
}

export function FilterPill({
  active,
  onClick,
  children,
}: {
  active?: boolean;
  onClick?: () => void;
  children: ReactNode;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        "inline-flex h-7 items-center gap-1.5 rounded-md border px-2.5 text-[12px] font-medium transition-colors",
        active
          ? "border-primary/50 bg-primary/15 text-foreground"
          : "border-border bg-[#1a1a23] text-muted-foreground hover:border-[#3d3d4a] hover:text-foreground",
      )}
    >
      {children}
    </button>
  );
}

export function Panel({
  className,
  children,
}: {
  className?: string;
  children: ReactNode;
}) {
  return (
    <div
      className={cn(
        "rounded-lg border border-border bg-[#1e1e29]",
        className,
      )}
    >
      {children}
    </div>
  );
}

export function EmptyState({
  title,
  description,
  action,
}: {
  title: string;
  description: string;
  action?: ReactNode;
}) {
  return (
    <div className="flex min-h-[420px] flex-col items-center justify-center px-6 py-12 text-center">
      <div className="mb-4 flex size-12 items-center justify-center rounded-full bg-primary/15 text-primary">
        <Radar className="size-6" />
      </div>
      <h2 className="text-lg font-semibold text-foreground">{title}</h2>
      <p className="mt-2 max-w-md text-[13px] leading-relaxed text-muted-foreground">
        {description}
      </p>
      {action ? <div className="mt-6">{action}</div> : null}
    </div>
  );
}
