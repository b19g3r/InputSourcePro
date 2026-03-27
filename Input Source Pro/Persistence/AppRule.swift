import Cocoa

enum PunctuationMode: String, CaseIterable, Codable, Identifiable {
    case global
    case forceEnglish
    case disabled

    var id: String { rawValue }
}

extension AppRule {
    var image: NSImage? {
        guard let path = url else { return nil }

        return NSWorkspace.shared.icon(forFile: path.path)
    }
}

extension AppRule {
    @MainActor
    var forcedKeyboard: InputSource? {
        guard let inputSourceId = inputSourceId else { return nil }

        return InputSource.sources.first { $0.id == inputSourceId }
    }

    var functionKeyMode: FKeyMode? {
        get {
            guard let rawValue = functionKeyModeRaw else { return nil }
            return FKeyMode(rawValue: rawValue)
        }
        set {
            functionKeyModeRaw = newValue?.rawValue
        }
    }

    var punctuationMode: PunctuationMode {
        get {
            guard let rawValue = punctuationModeRaw,
                  let mode = PunctuationMode(rawValue: rawValue)
            else { return .global }

            return mode
        }
        set {
            punctuationModeRaw = newValue.rawValue
        }
    }
}
