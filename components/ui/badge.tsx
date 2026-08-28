import { mergeProps } from "@base-ui/react/merge-props"
import { useRender } from "@base-ui/react/use-render"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const badgeVariants = cva(
  "group/badge inline-flex h-[18px] w-fit shrink-0 items-center justify-center gap-1 overflow-hidden rounded-full px-2 text-[10px] font-semibold uppercase tracking-[0.08em] whitespace-nowrap transition-colors focus-visible:ring-2 focus-visible:ring-ring/40 [&>svg]:pointer-events-none [&>svg]:size-2.5!",
  {
    variants: {
      variant: {
        default: "bg-primary/22 text-[#d4cbff]",
        secondary: "bg-white/8 text-[#d0cce0]",
        destructive: "bg-[#e65d6e]/18 text-[#f4a0aa]",
        outline: "border border-white/10 bg-white/4 text-[#c4c1d2]",
        ghost: "bg-transparent text-muted-foreground",
        link: "text-primary underline-offset-4 hover:underline",
        success: "bg-[#57d9a3]/16 text-[#7aecc0]",
        warning: "bg-[#f5a623]/16 text-[#f5c76a]",
        info: "bg-[#57bcf0]/16 text-[#8dd4ff]",
        channel:
          "border border-white/8 bg-[#ffffff]/6 text-[#d8d4e4]",
        ir: "border border-white/8 bg-transparent text-[#b8b3c8]",
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
