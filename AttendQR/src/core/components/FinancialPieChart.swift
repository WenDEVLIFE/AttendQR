import SwiftUI
import Charts

/// Financial overview component with two pie charts: Income vs Expenses and Category Breakdown.
struct FinancialPieChart: View {
    let stats: DashboardStats
    let expenses: [ExpenseModel]
    
    @Environment(\.colorScheme) var colorScheme
    private var isDark: Bool { colorScheme == .dark }
    
    // Calculate total for percentage calculation
    private var totalIncome: Double { stats.totalSalesIncome }
    private var totalExpenses: Double { stats.totalExpenses }
    private var netIncome: Double { totalIncome - totalExpenses }
    private var total: Double { totalIncome + totalExpenses }
    
    private let categoryColors: [String: Color] = [
        "Food": AppColors.warning,
        "Transportation": AppColors.blue500,
        "Entertainment": AppColors.blue400,
        "Utilities": AppColors.info,
        "Healthcare": AppColors.error,
        "Shopping": AppColors.blue300,
        "Other": AppColors.textSecondary
    ]
    
    private let fallbackColors: [Color] = [
        AppColors.warning,
        AppColors.blue500,
        AppColors.blue400,
        AppColors.info,
        AppColors.error,
        AppColors.blue300,
        AppColors.textSecondary
    ]

    var body: some View {
        VStack(spacing: 16) {
            if total == 0 {
                emptyState
            } else {
                financialOverviewChart
                expensesByCategoryChart
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "chart.pie")
                .font(.system(size: 48))
                .foregroundColor(isDark ? .white.opacity(0.5) : AppColors.textSecondary.opacity(0.5))
            
            Text("No data available")
                .font(.custom("ElmsSans", size: 16))
                .foregroundColor(isDark ? .white.opacity(0.7) : AppColors.textSecondary.opacity(0.7))
        }
        .frame(height: 300)
        .background(isDark ? AppColors.cardDark : AppColors.surface)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColors.border.opacity(0.3), lineWidth: 1)
        )
    }
    
    private var financialOverviewChart: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Financial Overview")
                    .font(.custom("ElmsSans", size: 18).weight(.bold))
                    .foregroundColor(isDark ? .white : AppColors.textPrimary)
                
                Text("Income vs Expenses Breakdown")
                    .font(.custom("ElmsSans", size: 14))
                    .foregroundColor(isDark ? .white.opacity(0.7) : AppColors.textSecondary.opacity(0.7))
            }
            
            HStack(alignment: .top, spacing: 16) {
                // Pie Chart
                ZStack {
                    if #available(iOS 17.0, *) {
                        Chart {
                            if totalIncome > 0 {
                                SectorMark(
                                    angle: .value("Income", totalIncome),
                                    innerRadius: .ratio(0.5),
                                    angularInset: 1.5
                                )
                                .foregroundStyle(isDark ? AppColors.blue400 : AppColors.success)
                            }
                            
                            if totalExpenses > 0 {
                                SectorMark(
                                    angle: .value("Expenses", totalExpenses),
                                    innerRadius: .ratio(0.5),
                                    angularInset: 1.5
                                )
                                .foregroundStyle(isDark ? AppColors.error.opacity(0.8) : AppColors.error)
                            }
                        }
                        .frame(height: 200)
                    } else {
                        // Fallback for older iOS versions if needed
                        Text("iOS 17+ Chart Required")
                    }
                }
                .frame(maxWidth: .infinity)
                
                // Legend
                VStack(alignment: .leading, spacing: 16) {
                    LegendItem(
                        label: "Total Income",
                        color: isDark ? AppColors.blue400 : AppColors.success,
                        value: totalIncome
                    )
                    
                    LegendItem(
                        label: "Total Expenses",
                        color: isDark ? AppColors.error.opacity(0.8) : AppColors.error,
                        value: totalExpenses
                    )
                    
                    LegendItem(
                        label: "Net Income",
                        color: isDark ? AppColors.blue300 : AppColors.primary,
                        value: netIncome
                    )
                }
                .frame(width: 120)
            }
        }
        .padding(20)
        .background(isDark ? AppColors.cardDark : AppColors.surface)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(isDark ? 0.3 : 0.05), radius: 8, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(AppColors.border.opacity(0.3), lineWidth: 1)
        )
    }
    
    private var expensesByCategoryChart: some View {
        let categoryTotals = groupExpensesByCategory()
        let totalExpensesByCategory = categoryTotals.values.reduce(0, +)
        
        if categoryTotals.isEmpty {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Expenses by Category")
                        .font(.custom("ElmsSans", size: 18).weight(.bold))
                        .foregroundColor(isDark ? .white : AppColors.textPrimary)
                    
                    Text("Breakdown of your spending")
                        .font(.custom("ElmsSans", size: 14))
                        .foregroundColor(isDark ? .white.opacity(0.7) : AppColors.textSecondary.opacity(0.7))
                }
                
                HStack(alignment: .top, spacing: 16) {
                    // Pie Chart
                    ZStack {
                        if #available(iOS 17.0, *) {
                            Chart {
                                ForEach(Array(categoryTotals.keys.enumerated()), id: \.offset) { index, category in
                                    let amount = categoryTotals[category] ?? 0
                                    SectorMark(
                                        angle: .value(category, amount),
                                        innerRadius: .ratio(0.5),
                                        angularInset: 1.5
                                    )
                                    .foregroundStyle(categoryColors[category] ?? fallbackColors[index % fallbackColors.count])
                                }
                            }
                            .frame(height: 200)
                        } else {
                            Text("iOS 17+ Chart Required")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Legend
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(categoryTotals.keys.sorted(by: { categoryTotals[$0]! > categoryTotals[$1]! }), id: \.self) { category in
                            let amount = categoryTotals[category] ?? 0
                            LegendItem(
                                label: category,
                                color: categoryColors[category] ?? fallbackColors[0],
                                value: amount,
                                showPercentage: true,
                                percentage: (amount / totalExpensesByCategory) * 100
                            )
                        }
                    }
                    .frame(width: 120)
                }
            }
            .padding(20)
            .background(isDark ? AppColors.cardDark : AppColors.surface)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(isDark ? 0.3 : 0.05), radius: 8, x: 0, y: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(AppColors.border.opacity(0.3), lineWidth: 1)
            )
        )
    }
    
    private func groupExpensesByCategory() -> [String: Double] {
        var totals: [String: Double] = [:]
        for expense in expenses {
            totals[expense.category, default: 0] += expense.amount
        }
        return totals
    }
}

// MARK: - Legend Item
struct LegendItem: View {
    let label: String
    let color: Color
    let value: Double
    var showPercentage: Bool = false
    var percentage: Double? = nil
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
                .padding(.top, 2)
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(label)
                        .font(.custom("ElmsSans", size: 12).weight(.medium))
                        .foregroundColor(colorScheme == .dark ? .white.opacity(0.8) : AppColors.textSecondary.opacity(0.8))
                        .lineLimit(1)
                    
                    if showPercentage, let percentage = percentage {
                        Spacer()
                        Text("\(String(format: "%.1f", percentage))%")
                            .font(.custom("ElmsSans", size: 11).weight(.semibold))
                            .foregroundColor(colorScheme == .dark ? .white.opacity(0.7) : AppColors.textSecondary.opacity(0.7))
                    }
                }
                
                Text(formatCurrency(value))
                    .font(.custom("ElmsSans", size: 14).weight(.bold))
                    .foregroundColor(colorScheme == .dark ? .white : AppColors.textPrimary)
            }
        }
    }
    
    private func formatCurrency(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₱"
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: value)) ?? "₱\(value)"
    }
}

// MARK: - Preview
struct FinancialPieChart_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Financial Pie Chart")
                    .font(.title.bold())
                    .padding(.top)
                
                FinancialPieChart(
                    stats: DashboardStats(
                        thisMonthSalary: 50000,
                        thisMonthExpenses: 25000,
                        totalExpenses: 25000,
                        totalProjects: 5,
                        totalSalary: 50000,
                        lastYearSalary: 45000,
                        totalSalesIncome: 50000,
                        thisMonthSalesIncome: 50000,
                        lastMonthSalary: 45000,
                        lastMonthExpenses: 20000,
                        previousTotalExpenses: 22000,
                        previousTotalProjects: 4,
                        previousTotalSalary: 48000,
                        yearBeforeLastSalary: 42000
                    ),
                    expenses: [
                        ExpenseModel(id: "1", title: "Lunch", category: "Food", amount: 5000, date: Date(), description: "Sample food expense"),
                        ExpenseModel(id: "2", title: "Grab", category: "Transportation", amount: 3000, date: Date(), description: "Sample transport expense"),
                        ExpenseModel(id: "3", title: "Movie", category: "Ente   rtainment", amount: 2000, date: Date(), description: "Sample entertainment expense"),
                        ExpenseModel(id: "4", title: "Electricity", category: "Utilities", amount: 8000, date: Date(), description: "Sample utility expense"),
                        ExpenseModel(id: "5", title: "Checkup", category: "Healthcare", amount: 4000, date: Date(), description: "Sample healthcare expense"),
                        ExpenseModel(id: "6", title: "New Shirt", category: "Shopping", amount: 3000, date: Date(), description: "Sample shopping expense")
                    ]
                )
                .padding()
                
                Text("Empty State")
                    .font(.headline)
                
                FinancialPieChart(
                    stats: DashboardStats(
                        thisMonthSalary: 0,
                        thisMonthExpenses: 0,
                        totalExpenses: 0,
                        totalProjects: 0,
                        totalSalary: 0,
                        lastYearSalary: 0,
                        totalSalesIncome: 0,
                        thisMonthSalesIncome: 0,
                        lastMonthSalary: nil,
                        lastMonthExpenses: nil,
                        previousTotalExpenses: nil,
                        previousTotalProjects: nil,
                        previousTotalSalary: nil,
                        yearBeforeLastSalary: nil
                    ),
                    expenses: []
                )
                .padding()
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}
