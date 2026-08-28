"use client";

import type { ReactNode } from "react";
import {
  LayoutDashboard,
  LineChart,
  Radar,
  Search,
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
  searchQuery,
  onSearchChange,
  searchPlaceholder = "Filter primitives…",
  meta,
  toolbarFilters,
  actions,
  footerAction,
  children,
}: {
  view: AppView;
  onView: (v: AppView) => void;
  secondaryTitle: string;
  secondaryItems: { id: string; label: string; count?: number }[];
  secondaryActive: string;
  onSecondarySelect: (id: string) => void;
  breadcrumb: ReactNode;
  searchQuery: string;
  onSearchChange: (q: string) => void;
  searchPlaceholder?: string;
  meta?: ReactNode;
  toolbarFilters?: ReactNode;
  actions?: ReactNode;
  footerAction?: { label: string; onClick: () => void; disabled?: boolean };
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
        <div className="mt-auto pb-2">
          <div className="mx-auto flex size-8 items-center justify-center rounded-full bg-[#6c5fc7] text-[10px] font-semibold text-white">
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
                "flex items-center justify-between rounded-lg px-3 py-2 text-left text-[13px] transition-colors",
                secondaryActive === item.id
                  ? "bg-[#6c5fc7] font-medium text-white"
                  : "text-[#c4c1d2] hover:bg-[#1c1c22] hover:text-white",
              )}
            >
              <span>{item.label}</span>
              {item.count != null ? (
                <span
                  className={cn(
                    "font-mono text-[11px]",
                    secondaryActive === item.id
                      ? "text-white/80"
                      : "text-[#8b8794]",
                  )}
                >
                  {item.count}
                </span>
              ) : null}
            </button>
          ))}
        </nav>
        {footerAction ? (
          <div className="mt-auto border-t border-[#2a2a32] p-3">
            <button
              type="button"
              disabled={footerAction.disabled}
              onClick={footerAction.onClick}
              className="w-full rounded-lg px-3 py-2 text-left text-[13px] text-[#c4c1d2] hover:bg-[#1c1c22] disabled:cursor-not-allowed disabled:opacity-40"
            >
              {footerAction.label}
            </button>
          </div>
        ) : null}
      </aside>

      <div className="flex min-w-0 flex-1 flex-col">
        <header className="shrink-0 border-b border-[#2a2a32] bg-[#1c1c22] px-4 py-2.5">
          <div className="flex flex-wrap items-center gap-2">
            <div className="mr-1 text-[13px] text-[#c4c1d2]">{breadcrumb}</div>
            {meta}
            {toolbarFilters}
            <div className="surface-tactile flex max-w-[360px] min-w-[160px] flex-1 items-center gap-2 px-3 py-1.5">
              <Search className="size-3.5 shrink-0 text-[#8b8794]" />
              <input
                value={searchQuery}
                onChange={(e) => onSearchChange(e.target.value)}
                className="min-w-0 flex-1 bg-transparent text-[13px] text-[#f0edf6] outline-none placeholder:text-[#8b8794]"
                placeholder={searchPlaceholder}
              />
            </div>
            <div className="ml-auto flex shrink-0 items-center gap-2">
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

export function FilterChip({
  label,
  active,
  onClick,
}: {
  label: string;
  active?: boolean;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        "btn-tactile h-8 px-2.5",
        active && "border-t-[#7a71e8] bg-[#3d3560] text-white",
      )}
    >
      {label}
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
