import { requireNativeView } from 'expo';
import * as React from 'react';

import { ExpoIosSecureViewProps } from './ExpoIosSecureView.types';
import { Platform } from 'react-native';

const NativeView: React.ComponentType<React.PropsWithChildren<ExpoIosSecureViewProps>> =
  requireNativeView('ExpoIosSecureView');

export default function ExpoIosSecureView({ children, ...props }: React.PropsWithChildren<ExpoIosSecureViewProps>) {
  return Platform.OS === "android"
    ? children
    : <NativeView {...props}>{children}</NativeView>;
}
