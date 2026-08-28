import { Button as ButtonPrimitive } from "@base-ui/react/button"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "group/button inline-flex shrink-0 items-center justify-center rounded-[6px] bg-clip-padding text-[13px] font-medium whitespace-nowrap outline-none select-none focus-visible:ring-2 focus-visible:ring-ring/40 disabled:pointer-events-none disabled:opacity-50 aria-invalid:ring-2 aria-invalid:ring-destructive/20 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
  {
    variants: {
      variant: {
        default:
          "btn-tactile-primary font-semibold text-white",
        tactile: "btn-tactile",
        outline: "btn-tactile text-foreground",
        secondary: "btn-tactile bg-[#2c2c35] text-secondary-foreground",
        ghost:
          "border border-transparent bg-transparent text-muted-foreground shadow-none hover:bg-muted hover:text-foreground active:translate-y-0",
        destructive:
          "btn-tactile border-t-destructive/20 bg-destructive/15 text-destructive shadow-[0_2px_0_0_rgba(0,0,0,0.45)] hover:bg-destructive/25",
        link: "border-transparent bg-transparent text-primary underline-offset-4 shadow-none hover:underline active:translate-y-0",
      },
      size: {
        default:
          "h-8 gap-1.5 px-2.5 has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2",
        xs: "h-6 gap-1 px-2 text-xs has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3",
        sm: "h-7 gap-1 px-2.5 text-[0.8rem] has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3.5",
        lg: "h-9 gap-1.5 px-3 has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2",
        icon: "size-8 gap-0 border-0 border-t border-white/10 bg-[#211d24] p-0 text-white shadow-[0_2px_0_0_#0a0a0c] hover:bg-[#2a2630] active:translate-y-0.5 active:shadow-none",
        "icon-xs":
          "size-6 gap-0 border-0 border-t border-white/10 bg-[#211d24] p-0 text-white shadow-[0_2px_0_0_#0a0a0c] hover:bg-[#2a2630] active:translate-y-0.5 active:shadow-none [&_svg:not([class*='size-'])]:size-3",
        "icon-sm":
          "size-7 gap-0 border-0 border-t border-white/10 bg-[#211d24] p-0 text-white shadow-[0_2px_0_0_#0a0a0c] hover:bg-[#2a2630] active:translate-y-0.5 active:shadow-none",
        "icon-lg":
          "size-9 gap-0 border-0 border-t border-white/10 bg-[#211d24] p-0 text-white shadow-[0_2px_0_0_#0a0a0c] hover:bg-[#2a2630] active:translate-y-0.5 active:shadow-none",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

function Button({
  className,
  variant = "default",
  size = "default",
  ...props
}: ButtonPrimitive.Props & VariantProps<typeof buttonVariants>) {
  return (
    <ButtonPrimitive
      data-slot="button"
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
