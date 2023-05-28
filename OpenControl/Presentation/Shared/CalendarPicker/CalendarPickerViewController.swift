//
//  OCTextField.swift
//  OpenControl
//
//  Created by Vladislav Panev on 23.05.2023.
//

import UIKit

class CalendarPickerViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var headerView = CalendarPickerHeaderView { [weak self] in
        guard let self = self else { return }
        
        self.baseDate = self.calendar.date(
            byAdding: .month,
            value: -1,
            to: self.baseDate
        ) ?? self.baseDate
    } rightButtonTappedCompletionHandler: { [weak self] in
        guard let self = self else { return }
        
        self.baseDate = self.calendar.date(
            byAdding: .month,
            value: 1,
            to: self.baseDate
        ) ?? self.baseDate
    }

    
    private lazy var footerView = CalendarPickerFooterView { [weak self] id in
        let slot = self?.consultationSlots.first(where: { $0.id == id })
        guard let slot = slot else { return }
        self?.selectedSlotChanged(slot)
    }
    
    // MARK: Calendar Data Values
    
    private var selectedDate: Date
    private let consultationSlots: [ConsultationSlot]
    private var baseDate: Date {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            collectionView.reloadData()
            headerView.baseDate = baseDate
            configureSlotsForNewDate(newDate: baseDate)
        }
    }
    
    private var days: [Day] = []
    
    private var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }
    
    private let selectedSlotChanged: ((ConsultationSlot) -> Void)
    private let calendar = Calendar(identifier: .iso8601)
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()
    
    // MARK: Initializers
    
    init(
        baseDate: Date,
        consultationSlots: [ConsultationSlot],
        selectedSlotChanged: @escaping ((ConsultationSlot) -> Void)
    ) {
        self.selectedDate = baseDate
        self.baseDate = baseDate
        self.selectedSlotChanged = selectedSlotChanged
        self.consultationSlots = consultationSlots
        
        super.init(nibName: nil, bundle: nil)
        
        self.configureSlotsForNewDate(newDate: baseDate)
        self.days = generateDaysInMonth(for: baseDate)
//        modalPresentationStyle = .overCurrentContext
//        modalTransitionStyle = .crossDissolve
//        definesPresentationContext = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(headerView)
        view.addSubview(footerView)
        
        var constraints: [NSLayoutConstraint] = []
        
        constraints.append(contentsOf: [
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -25),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        constraints.append(contentsOf: [
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            footerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 47),
            footerView.heightAnchor.constraint(equalToConstant: 95),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34)
        ])
        
        NSLayoutConstraint.activate(constraints)
        
        collectionView.register(
            CalendarDateCollectionViewCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier
        )
        
        collectionView.dataSource = self
        collectionView.delegate = self
        headerView.baseDate = baseDate
        view.backgroundColor = .white
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator
    ) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
}

private extension CalendarPickerViewController {
    func configureSlotsForNewDate(newDate: Date) {
        let slots = consultationSlots.filter({ slot in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            let date = dateFormatter.date(from: slot.slotDate)!
            return date == newDate
        })
        let data = slots.compactMap { slot in
            TimeCell.Model(
                id: slot.id,
                name: String(slot.slotTime.split(separator: "-").first ?? ""),
                isSelected: false,
                status: slot.status
            )
        }
        let sortedData = data.sorted(by: <)
        footerView.timeData = sortedData
    }
}

// MARK: - Day Generation
private extension CalendarPickerViewController {
    // 1
    func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        // 2
        guard
            let numberOfDaysInMonth = calendar.range(
                of: .day,
                in: .month,
                for: baseDate)?.count,
            let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            // 3
            throw CalendarDataError.metadataGeneration
        }
        
        // 4
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 5
        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    // 1
    func generateDaysInMonth(for baseDate: Date) -> [Day] {
        // 2
        guard let metadata = try? monthMetadata(for: baseDate) else {
            preconditionFailure("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday - 1
        let firstDayOfMonth = metadata.firstDay
        
        // 3
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                // 4
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                // 5
                let dayOffset =
                isWithinDisplayedMonth ?
                day - offsetInInitialRow :
                -(offsetInInitialRow - day)
                
                // 6
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        
        return days
    }
    
    // 7
    func generateDay(
        offsetBy dayOffset: Int,
        for baseDate: Date,
        isWithinDisplayedMonth: Bool
    ) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate)
        ?? baseDate
        
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isSelected: calendar.isDate(date, inSameDayAs: selectedDate),
            isWithinDisplayedMonth: isWithinDisplayedMonth
        )
    }
    
    // 1
    func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date
    ) -> [Day] {
        // 2
        guard
            let lastDayInMonth = calendar.date(
                byAdding: DateComponents(month: 1, day: -1),
                to: firstDayOfDisplayedMonth)
        else {
            return []
        }
        
        // 3
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }
        
        // 4
        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    offsetBy: $0,
                    for: lastDayInMonth,
                    isWithinDisplayedMonth: false)
            }
        
        return days
    }
    
    enum CalendarDataError: Error {
        case metadataGeneration
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarPickerViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        days.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let day = days[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CalendarDateCollectionViewCell.reuseIdentifier,
            for: indexPath) as! CalendarDateCollectionViewCell
        // swiftlint:disable:previous force_cast
        
        cell.day = day
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CalendarPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let day = days[indexPath.row]
        selectedDate = day.date
        baseDate = day.date
        days = generateDaysInMonth(for: baseDate)
        collectionView.reloadData()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = Int(collectionView.frame.width / 7)
        let height = Int(collectionView.frame.height) / numberOfWeeksInBaseDate
        return CGSize(width: width, height: height)
    }
}
