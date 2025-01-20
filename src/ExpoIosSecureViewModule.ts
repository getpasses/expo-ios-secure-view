import { NativeModule, requireNativeModule } from 'expo';

import { ExpoIosSecureViewModuleEvents } from './ExpoIosSecureView.types';

declare class ExpoIosSecureViewModule extends NativeModule<ExpoIosSecureViewModuleEvents> {
}

// This call loads the native module object from the JSI.
export default requireNativeModule<ExpoIosSecureViewModule>('ExpoIosSecureView');
