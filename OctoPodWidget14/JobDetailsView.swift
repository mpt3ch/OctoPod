import SwiftUI

struct JobDetailsView: View {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        // Show short version of date and hour
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var printerName: String
    var entry: Provider.Entry
    
    var body: some View {
        Text(printerName)
            .font(.subheadline)

        if let progress = entry.printJobDataService?.progress, let eta = entry.printJobDataService?.printEstimatedCompletion, let printerStatus = entry.printJobDataService?.printerStatus {
            
            ProgressBarView(progress: .constant(progress))
                .frame(width: 60.0, height: 60.0)
            // Display ETA only if progress is not 100%
            if printerStatus == "Printing" {
                HStack(spacing: 30) {
                    Image("ETA")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                    Text(eta)
                        .font(.footnote)
                        .minimumScaleFactor(0.65)
                }.padding(.horizontal, 5)
            } else {
                Text(printerStatus)
                    .font(.footnote)
            }
        } else if let printerStatus = entry.printJobDataService?.printerStatus {
            Spacer()
            Text(printerStatus)
                .font(.body)
            Spacer()
        }
        
        Text("\(entry.date, formatter: Self.dateFormatter)")
            .font(.caption2)
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(printerName: "MK3", entry: SimpleEntry(date: Date(), configuration: WidgetConfigurationIntent(), printJobDataService: nil, cameraService: nil))
    }
}
