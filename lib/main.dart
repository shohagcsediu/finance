import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF1E88E5),
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        fontFamily: 'SF Pro Display',
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    TransactionsPage(),
    BudgetPage(),
    InvestmentsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF1E88E5),
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Transactions'),
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Budget'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Investments'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// 1. Dashboard Page
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning,', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                      Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Color(0xFF1E88E5),
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Balance Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 16)),
                    SizedBox(height: 8),
                    Text('\$24,580.50', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        _buildBalanceItem('Income', '\$8,450', Icons.arrow_upward, Colors.green),
                        SizedBox(width: 30),
                        _buildBalanceItem('Expense', '\$3,230', Icons.arrow_downward, Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Quick Actions
              Text('Quick Actions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(child: _buildActionCard('Send Money', Icons.send, Color(0xFF4CAF50))),
                  SizedBox(width: 15),
                  Expanded(child: _buildActionCard('Receive', Icons.qr_code_scanner, Color(0xFFFF9800))),
                  SizedBox(width: 15),
                  Expanded(child: _buildActionCard('Pay Bills', Icons.receipt, Color(0xFF9C27B0))),
                ],
              ),
              SizedBox(height: 30),

              // Recent Transactions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: Text('See All')),
                ],
              ),
              SizedBox(height: 15),
              _buildTransactionItem('Grocery Store', 'Today', '-\$85.20', Icons.shopping_cart),
              _buildTransactionItem('Salary Deposit', 'Yesterday', '+\$3,200.00', Icons.account_balance),
              _buildTransactionItem('Netflix Subscription', '2 days ago', '-\$15.99', Icons.play_circle_fill),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceItem(String title, String amount, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
            Text(amount, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Color(0xFF1E88E5).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Color(0xFF1E88E5)),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text(amount, style: TextStyle(
            fontWeight: FontWeight.bold,
            color: amount.startsWith('+') ? Colors.green : Colors.red,
          )),
        ],
      ),
    );
  }
}

// 2. Transactions Page
class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Transactions', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
          IconButton(icon: Icon(Icons.filter_list, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', true),
                  _buildFilterChip('Income', false),
                  _buildFilterChip('Expense', false),
                  _buildFilterChip('Transfer', false),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Transactions List
            _buildTransactionGroup('Today', [
              TransactionItem('Starbucks Coffee', 'Food & Drink', '-\$12.50', Icons.local_cafe),
              TransactionItem('Uber Ride', 'Transport', '-\$18.75', Icons.directions_car),
            ]),
            _buildTransactionGroup('Yesterday', [
              TransactionItem('Salary Deposit', 'Income', '+\$3,200.00', Icons.account_balance),
              TransactionItem('Netflix', 'Entertainment', '-\$15.99', Icons.play_circle_fill),
              TransactionItem('Grocery Store', 'Shopping', '-\$85.20', Icons.shopping_cart),
            ]),
            _buildTransactionGroup('This Week', [
              TransactionItem('Electric Bill', 'Utilities', '-\$120.00', Icons.flash_on),
              TransactionItem('Freelance Work', 'Income', '+\$800.00', Icons.work),
              TransactionItem('Amazon Purchase', 'Shopping', '-\$45.99', Icons.shopping_bag),
            ]),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF1E88E5),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {},
        backgroundColor: Colors.white,
        selectedColor: Color(0xFF1E88E5),
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }

  Widget _buildTransactionGroup(String title, List<TransactionItem> transactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
        ),
        ...transactions.map((transaction) => _buildTransactionTile(transaction)).toList(),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildTransactionTile(TransactionItem transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1E88E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction.icon, color: Color(0xFF1E88E5)),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(transaction.title, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(transaction.category, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text(
            transaction.amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: transaction.amount.startsWith('+') ? Colors.green : Colors.red,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItem {
  final String title;
  final String category;
  final String amount;
  final IconData icon;

  TransactionItem(this.title, this.category, this.amount, this.icon);
}

// 3. Budget Page
class BudgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Budget', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.calendar_today, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Monthly Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monthly Budget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('August 2024', style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Spent', style: TextStyle(color: Colors.grey[600])),
                            Text('\$2,840', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Budget', style: TextStyle(color: Colors.grey[600])),
                            Text('\$4,500', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  LinearProgressIndicator(
                    value: 0.63,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                    minHeight: 8,
                  ),
                  SizedBox(height: 10),
                  Text('63% of budget used • \$1,660 remaining', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Budget Categories
            Text('Budget Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _buildBudgetCategory('Food & Dining', '\$320', '\$500', 0.64, Color(0xFF4CAF50)),
            _buildBudgetCategory('Transportation', '\$180', '\$300', 0.60, Color(0xFFFF9800)),
            _buildBudgetCategory('Entertainment', '\$240', '\$200', 1.2, Color(0xFFE91E63)),
            _buildBudgetCategory('Shopping', '\$450', '\$600', 0.75, Color(0xFF9C27B0)),
            _buildBudgetCategory('Utilities', '\$220', '\$250', 0.88, Color(0xFF2196F3)),
            _buildBudgetCategory('Healthcare', '\$80', '\$150', 0.53, Color(0xFF00BCD4)),

            SizedBox(height: 30),

            // Add Budget Category Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Color(0xFF1E88E5), style: BorderStyle.solid, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Color(0xFF1E88E5)),
                  SizedBox(width: 10),
                  Text('Add New Category', style: TextStyle(color: Color(0xFF1E88E5), fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCategory(String category, String spent, String budget, double progress, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
              Text('$spent / $budget', style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          SizedBox(height: 15),
          LinearProgressIndicator(
            value: progress > 1 ? 1 : progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(progress > 1 ? Colors.red : color),
            minHeight: 6,
          ),
          SizedBox(height: 8),
          Text(
            progress > 1 ? 'Over budget by \$${(double.parse(spent.substring(1)) - double.parse(budget.substring(1))).toStringAsFixed(0)}'
                : '${(progress * 100).toInt()}% used',
            style: TextStyle(
              color: progress > 1 ? Colors.red : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// 4. Investments Page
class InvestmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Investments', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.show_chart, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Portfolio Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Portfolio Value', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 8),
                  Text('\$18,450.75', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: Colors.white, size: 20),
                      SizedBox(width: 5),
                      Text('+\$1,240.50 (+7.21%)', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  Text('This month', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Quick Actions
            Row(
              children: [
                Expanded(child: _buildInvestmentAction('Buy', Icons.add, Color(0xFF4CAF50))),
                SizedBox(width: 15),
                Expanded(child: _buildInvestmentAction('Sell', Icons.remove, Color(0xFFF44336))),
                SizedBox(width: 15),
                Expanded(child: _buildInvestmentAction('Transfer', Icons.swap_horiz, Color(0xFF2196F3))),
              ],
            ),
            SizedBox(height: 30),

            // Holdings
            Text('Your Holdings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _buildHolding('Apple Inc.', 'AAPL', '45 shares', '\$8,100.00', '+2.4%', Color(0xFF4CAF50)),
            _buildHolding('Microsoft Corp.', 'MSFT', '25 shares', '\$6,750.00', '+1.8%', Color(0xFF4CAF50)),
            _buildHolding('Tesla Inc.', 'TSLA', '15 shares', '\$2,340.00', '-0.9%', Color(0xFFF44336)),
            _buildHolding('Amazon.com Inc.', 'AMZN', '8 shares', '\$1,260.75', '+3.2%', Color(0xFF4CAF50)),

            SizedBox(height: 30),

            // Market News
            Text('Market News', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _buildNewsItem('Tech Stocks Rally as AI Adoption Grows', '2 hours ago'),
            _buildNewsItem('Federal Reserve Hints at Rate Stability', '5 hours ago'),
            _buildNewsItem('Clean Energy Sector Shows Strong Growth', '1 day ago'),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentAction(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildHolding(String name, String symbol, String shares, String value, String change, Color changeColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF1E88E5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(symbol.substring(0, 2), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E88E5))),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
                    Text(shares, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: changeColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(change, style: TextStyle(color: changeColor, fontSize: 12, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNewsItem(String headline, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF1E88E5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(headline, style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 5. Profile Page
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.settings, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFF1E88E5),
                        child: Text('JD', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Color(0xFF4CAF50),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.edit, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('john.doe@email.com', style: TextStyle(color: Colors.grey[600])),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildProfileStat('Transactions', '248'),
                      _buildProfileStat('Budget Goals', '12'),
                      _buildProfileStat('Investments', '8'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Menu Items
            _buildMenuItem(Icons.account_balance_wallet, 'Account & Cards', 'Manage your accounts and cards'),
            _buildMenuItem(Icons.security, 'Security', 'Password, PIN, and biometric settings'),
            _buildMenuItem(Icons.notifications, 'Notifications', 'Customize your notification preferences'),
            _buildMenuItem(Icons.pie_chart, 'Reports', 'View detailed financial reports'),
            _buildMenuItem(Icons.help_outline, 'Help & Support', 'Get help and contact support'),
            _buildMenuItem(Icons.info_outline, 'About', 'App version and legal information'),

            SizedBox(height: 30),

            // Logout Button
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1E88E5))),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1E88E5).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Color(0xFF1E88E5)),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
        ],
      ),
    );
  }
}