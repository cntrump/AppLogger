import AppKit

extension String {
    func withTermColor(_ number: Int) -> String {
        "\u{001B}[\(number)m" + self + "\u{001B}[0m"
    }
}

struct AppVersion {
    let major: Int
    let minor: Int
    let patch: Int

    init(major: Int, minor: Int, patch: Int) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    func printVersionInfo() {
        print("version: \(major).\(minor).\(patch)".withTermColor(35))
    }
}

struct RunningAppInfo: Equatable {
    let bundleId: String
    let name: String
    let path: String

    init(bundleId: String, name: String, path: String) {
        self.bundleId = bundleId
        self.name = name
        self.path = path
    }

    func printAppInfo() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        print("\(formatter.string(from: Date()).withTermColor(90)) \(name.withTermColor(31))(\(bundleId.withTermColor(36)))[\(path.withTermColor(32))]")
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.bundleId == rhs.bundleId &&
        lhs.name == rhs.name &&
        lhs.path == rhs.path
    }
}

let appVersion = AppVersion(major: 1, minor: 0, patch: 0)
appVersion.printVersionInfo()

var currentRunningApp: RunningAppInfo?

while true {
    guard let appInfo = NSWorkspace.shared.activeApplication(),
          let appBundleId = appInfo["NSApplicationBundleIdentifier"] as? String,
          let appName = appInfo["NSApplicationName"] as? String,
          let appPath = appInfo["NSApplicationPath"] as? String else {
        sleep(1)
        continue
    }

    let current = RunningAppInfo(bundleId: appBundleId, name: appName, path: appPath)
    if current == currentRunningApp {
        sleep(1)
        continue
    }

    current.printAppInfo()
    currentRunningApp = current

    sleep(1)
}
