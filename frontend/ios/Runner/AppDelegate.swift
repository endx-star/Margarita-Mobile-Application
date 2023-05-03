import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [
      
      // GMSServices provideAPIKey:@"YOUR KEY HERE",
      // GeneratedPluginRegistrant registerWithRegistry:self,
      UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
   GMSServices.provideAPIKey("AIzaSyDO_cfwPa7MmOIwI6t-gcGiTkNtim0cvvw")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
