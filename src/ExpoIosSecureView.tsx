import { requireNativeView } from "expo"
import * as React from "react"
import { Platform } from "react-native"

import { ExpoIosSecureViewProps } from "./ExpoIosSecureView.types"

export default function ExpoIosSecureView({
  children,
  secureMode,
  ...props
}: React.PropsWithChildren<ExpoIosSecureViewProps>) {
  if (!secureMode || Platform.OS === "android") {
    return children
  }
  const NativeView: React.ComponentType<
    React.PropsWithChildren<ExpoIosSecureViewProps>
  > = requireNativeView("ExpoIosSecureView")

  return <NativeView {...props}>{children}</NativeView>
}
