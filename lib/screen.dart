import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider_crypto.dart';

class CryptoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pasar Crypto'),
      ),
      body: FutureBuilder(
        future: Provider.of<CryptoProvider>(context, listen: false).fetchCryptos(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<CryptoProvider>(
              builder: (ctx, cryptoProvider, _) => SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('#')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Price')),
                      DataColumn(label: Text('1h %')),
                      DataColumn(label: Text('24h %')),
                      DataColumn(label: Text('7d %')),
                      DataColumn(label: Text('Market Cap')),
                      DataColumn(label: Text('Volume(24h)')),
                      DataColumn(label: Text('Circulating Supply')),
                    ],
                    rows: cryptoProvider.cryptos.map((crypto) {
                      print('Logo URL: ${crypto.logoUrl}');
                      return DataRow(cells: [
                        DataCell(Text(crypto.rank.toString())),
                        DataCell(Row(
                          children: [
                            Image.network(
                              crypto.logoUrl,
                              width: 24,
                              height: 24,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error, size: 24);
                              },
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(crypto.name),
                                Text(crypto.symbol),
                              ],
                            ),
                          ],
                        )),
                        DataCell(Text('\$${crypto.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.green))),
                        DataCell(Text('${crypto.change1h.toStringAsFixed(2)}%', style: TextStyle(color: crypto.change1h >= 0 ? Colors.green : Colors.red))),
                        DataCell(Text('${crypto.change24h.toStringAsFixed(2)}%', style: TextStyle(color: crypto.change24h >= 0 ? Colors.green : Colors.red))),
                        DataCell(Text('${crypto.change7d.toStringAsFixed(2)}%', style: TextStyle(color: crypto.change7d >= 0 ? Colors.green : Colors.red))),
                        DataCell(Text('\$${crypto.marketCap.toStringAsFixed(2)}')),
                        DataCell(Text('\$${crypto.volume24h.toStringAsFixed(2)}')),
                        DataCell(Text('${crypto.circulatingSupply.toStringAsFixed(2)} ${crypto.symbol}')),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}