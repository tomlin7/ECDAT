import { mergeProps } from "@base-ui/react/merge-props"
import { useRender } from "@base-ui/react/use-render"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const badgeVariants = cva(
  "group/badge inline-flex h-5 w-fit shrink-0 items-center justify-center gap-1 overflow-hidden rounded-md border px-1.5 py-0 text-[11px] font-medium uppercase tracking-wide whitespace-nowrap transition-colors focus-visible:ring-2 focus-visible:ring-ring/40 [&>svg]:pointer-events-none [&>svg]:size-3!",
  {
    variants: {
      variant: {
        default: "border-primary/30 bg-primary/20 text-[#c4b5fd]",
        secondary:
          "border-border bg-secondary text-muted-foreground",
        destructive:
          "border-destructive/30 bg-destructive/15 text-destructive",
        outline:
          "border-border bg-transparent text-muted-foreground",
        ghost: "border-transparent bg-transparent text-muted-foreground",
        link: "text-primary underline-offset-4 hover:underline",
        success: "border-[#57d9a3]/30 bg-[#57d9a3]/15 text-[#57d9a3]",
        warning: "border-[#f5a623]/30 bg-[#f5a623]/15 text-[#f5a623]",
        info: "border-[#57bcf0]/30 bg-[#57bcf0]/15 text-[#57bcf0]",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  }
)

function Badge({
  className,
  variant = "default",
  render,
  ...props
}: useRender.ComponentProps<"span"> & VariantProps<typeof badgeVariants>) {
  return useRender({
    defaultTagName: "span",
    props: mergeProps<"span">(
      {
        className: cn(badgeVariants({ variant }), className),
      },
      props
    ),
    render,
    state: {
      slot: "badge",
      variant,
    },
  })
}

export { Badge, badgeVariants }
