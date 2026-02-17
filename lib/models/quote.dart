class Quote {
  final String symbol;
  final String description;
  final double bid;
  final double ask;
  final double change;

  Quote({
    required this.symbol,
    required this.description,
    required this.bid,
    required this.ask,
    required this.change,
  });
}

final List<Quote> mockQuotes = [
  Quote(symbol: 'EURUSD', description: 'Euro vs US Dollar', bid: 1.0845, ask: 1.0846, change: 0.12),
  Quote(symbol: 'GBPUSD', description: 'Great Britain Pound vs US Dollar', bid: 1.2634, ask: 1.2635, change: -0.05),
  Quote(symbol: 'USDJPY', description: 'US Dollar vs Japanese Yen', bid: 150.23, ask: 150.24, change: 0.45),
  Quote(symbol: 'XAUUSD', description: 'Gold vs US Dollar', bid: 2024.50, ask: 2024.65, change: -0.82),
  Quote(symbol: 'BTCUSD', description: 'Bitcoin vs US Dollar', bid: 52140.0, ask: 52145.5, change: 2.34),
  Quote(symbol: 'ETHUSD', description: 'Ethereum vs US Dollar', bid: 2845.2, ask: 2846.1, change: 1.56),
  Quote(symbol: 'AAPL', description: 'Apple Inc.', bid: 182.31, ask: 182.35, change: -0.45),
  Quote(symbol: 'TSLA', description: 'Tesla, Inc.', bid: 193.45, ask: 193.58, change: -3.21),
  Quote(symbol: 'MSFT', description: 'Microsoft Corp.', bid: 404.32, ask: 404.45, change: 1.12),
  Quote(symbol: 'GOOGL', description: 'Alphabet Inc.', bid: 145.67, ask: 145.80, change: 0.85),
  Quote(symbol: 'AMZN', description: 'Amazon.com Inc.', bid: 168.22, ask: 168.35, change: -0.42),
  Quote(symbol: 'NFLX', description: 'Netflix, Inc.', bid: 585.12, ask: 585.30, change: 4.56),
  Quote(symbol: 'NVDA', description: 'NVIDIA Corp.', bid: 726.13, ask: 726.30, change: 12.45),
  Quote(symbol: 'META', description: 'Meta Platforms Inc.', bid: 473.32, ask: 473.50, change: -1.23),
  Quote(symbol: 'V', description: 'Visa Inc.', bid: 278.45, ask: 278.55, change: 0.15),
  Quote(symbol: 'JPM', description: 'JPMorgan Chase & Co.', bid: 182.12, ask: 182.25, change: 0.67),
  Quote(symbol: 'DIS', description: 'The Walt Disney Co.', bid: 110.45, ask: 110.60, change: -2.34),
  Quote(symbol: 'UBER', description: 'Uber Technologies, Inc.', bid: 78.45, ask: 78.60, change: 5.12),
  Quote(symbol: 'ADBE', description: 'Adobe Inc.', bid: 540.23, ask: 540.50, change: -1.45),
  Quote(symbol: 'CRM', description: 'Salesforce, Inc.', bid: 285.12, ask: 285.30, change: 0.89),
  Quote(symbol: 'AMD', description: 'Advanced Micro Devices', bid: 174.45, ask: 174.60, change: -3.12),
  Quote(symbol: 'PYPL', description: 'PayPal Holdings, Inc.', bid: 58.32, ask: 58.45, change: 0.45),
];

