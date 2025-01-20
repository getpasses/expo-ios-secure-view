import ExpoModulesCore

public class ExpoIosSecureViewModule: Module {
    public func definition() -> ModuleDefinition {
        Name("ExpoIosSecureView")
        View(ExpoIosSecureView.self) {
            Prop("secureMode") { (view: ExpoIosSecureView, secureMode: Bool) in
                view.secureMode = secureMode
            }
        }
    }
}
