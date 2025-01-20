import type { StyleProp, ViewStyle } from 'react-native';

export type OnLoadEventPayload = {
  url: string;
};

export type ExpoIosSecureViewModuleEvents = {
  onChange: (params: ChangeEventPayload) => void;
};

export type ChangeEventPayload = {
  value: string;
};

export type ExpoIosSecureViewProps = {
  secureMode?: boolean;
  style?: StyleProp<ViewStyle>;
};
