import Foundation

extension String {
    /// Converts an optional ISO8601 date string (e.g. "2026-01-18T10:00:56Z")
    /// into a displayable formatted date string.
    ///
    /// - Parameter format: The output date format (default is "dd MMM yyyy, HH:mm")
    /// - Returns: A formatted date string or `nil` if parsing fails.
    func formattedDate(_ format: String = "dd MMM yyyy, HH:mm") -> String? {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime]

        guard let date = isoFormatter.date(from: self) else {
            return nil
        }

        let displayFormatter = DateFormatter()
        displayFormatter.locale = Locale.current
        displayFormatter.dateFormat = format

        return displayFormatter.string(from: date)
    }
}
