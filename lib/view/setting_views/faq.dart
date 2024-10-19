import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).FAQ),
        backgroundColor: Colors.grey,

      ),
      body: ListView(
        children: [
          ExpansionTile(
            title:
                Text(S.of(context).q1),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  
                  '${S.of(context).a_q1}\n'
                  ' ${S.of(context).a_q1}\n'
                  '\t${S.of(context).a1_q1}\n'
                  '\t${S.of(context).a2_q1}\n'
                  '\t${S.of(context).a3_q1}\n'
                  '\t${S.of(context).a4_q1}\n'
                  '\t${S.of(context).a5_q1}\n'
                  
                ),
              ),
            ],
          ),
          ExpansionTile(
            title:
                Text(S.of(context).q2),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  
                  '${S.of(context).a1_q2}\n'

                  
                ),
              ),
            ],
          ),
          ExpansionTile(
            title:
                Text(S.of(context).q3),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  
                  '${S.of(context).a1_q3}\n'

                  
                ),
              ),
            ],
          ),
          ExpansionTile(
            title:
                Text(S.of(context).q4),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  
                  '${S.of(context).a1_q4}\n'

                  
                ),
              ),
            ],
          ),
          ExpansionTile(
            title:
                Text(S.of(context).q5),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  
                  '${S.of(context).a1_q5}\n'

                  
                ),
              ),
            ],
          ),
          ExpansionTile(
            title:
                Text(S.of(context).q6),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  
                  '${S.of(context).a1_q6}\n'

                  
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
