"use client";

import { useState, type ReactNode } from "react";
import {
  ChevronsLeft,
  ChevronsRight,
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
  const [navCollapsed, setNavCollapsed] = useState(false);

  return (
    <div className="flex h-screen min-h-0 bg-[#1c1c22] text-[#f0edf6]">
      {/* Primary actionbar */}
      <aside className="flex w-[74px] shrink-0 flex-col items-center border-r border-[#2a2a32] bg-[#1a1a1f] py-3">
        <div className="btn-tactile-logo mb-5 size-10 text-sm">E</div>

        <nav className="flex w-full flex-col items-center gap-1">
          {ICON_NAV.map(({ id, icon: Icon, label }) => {
            const active = view === id;
            return (
              <button
                key={id}
                type="button"
                onClick={() => onView(id)}
                className="group flex w-full flex-col items-center gap-0.5 px-1 py-0.5"
              >
                <span
                  className={cn(
                    "flex size-10 items-center justify-center rounded-lg border-2 transition-colors",
                    active
                      ? "border-[#7c6cf0] text-white"
                      : "border-transparent text-[#9b97a6] group-hover:text-[#e8e6ef]",
                  )}
                >
                  <Icon className="size-[18px]" strokeWidth={1.75} />
                </span>
                <span
                  className={cn(
                    "max-w-[68px] truncate text-center text-[10px] leading-tight",
                    active
                      ? "font-medium text-white"
                      : "text-[#9b97a6] group-hover:text-[#e8e6ef]",
                  )}
                >
                  {label}
                </span>
              </button>
            );
          })}
        </nav>

        <div className="mt-auto flex flex-col items-center gap-3 pb-1">
          <div className="btn-tactile-logo-accent size-9 text-[10px]">EC</div>
        </div>
      </aside>

      {/* Secondary navigation panel */}
      {!navCollapsed ? (
        <aside className="flex w-[220px] shrink-0 flex-col border-r border-[#2a2a32] bg-[#1a1a1f]">
          <div className="flex items-center justify-between px-3 pt-3 pb-2">
            <span className="text-[15px] font-semibold text-white">
              {secondaryTitle}
            </span>
            <button
              type="button"
              onClick={() => setNavCollapsed(true)}
              className="flex size-7 items-center justify-center rounded-md border border-transparent text-[#8b8794] transition-colors hover:border-[#3d3d48] hover:text-white"
              title="Collapse sidebar"
            >
              <ChevronsLeft className="size-4" />
            </button>
          </div>

          <nav className="flex flex-col gap-0.5 px-2">
            {secondaryItems.map((item) => {
              const active = secondaryActive === item.id;
              return (
                <button
                  key={item.id}
                  type="button"
                  onClick={() => onSecondarySelect(item.id)}
                  className={cn(
                    "flex w-full items-center justify-between rounded-md px-3 py-1.5 text-left text-[13px] transition-colors",
                    active
                      ? "bg-[#7553ff] font-medium text-white"
                      : "border border-transparent text-[#c4c1d2] hover:border-[#3d3d48] hover:text-white",
                  )}
                >
                  <span>{item.label}</span>
                  {item.count != null ? (
                    <span
                      className={cn(
                        "font-mono text-[11px]",
                        active ? "text-white/85" : "text-[#8b8794]",
                      )}
                    >
                      {item.count}
                    </span>
                  ) : null}
                </button>
              );
            })}
          </nav>

          {footerAction ? (
            <div className="mt-auto border-t border-[#2a2a32] p-3">
              <button
                type="button"
                disabled={footerAction.disabled}
                onClick={footerAction.onClick}
                className="w-full rounded-md border border-transparent px-3 py-1.5 text-left text-[13px] text-[#c4c1d2] transition-colors hover:border-[#3d3d48] hover:text-white disabled:cursor-not-allowed disabled:opacity-40"
              >
                {footerAction.label}
              </button>
            </div>
          ) : null}
        </aside>
      ) : (
        <div className="flex w-10 shrink-0 flex-col border-r border-[#2a2a32] bg-[#1a1a1f]">
          <button
            type="button"
            onClick={() => setNavCollapsed(false)}
            className="mx-auto mt-3 flex size-7 items-center justify-center rounded-md border border-transparent text-[#8b8794] transition-colors hover:border-[#3d3d48] hover:text-white"
            title="Expand sidebar"
          >
            <ChevronsRight className="size-4" />
          </button>
        </div>
      )}

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
