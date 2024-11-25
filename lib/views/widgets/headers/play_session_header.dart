import 'package:flutter/material.dart';
import 'package:my_fit_buddy/views/themes/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_fit_buddy/views/themes/font_weight.dart';
import 'package:my_fit_buddy/views/widgets/buttons/play_session_set_button.dart';

class PlaySessionHeader extends StatelessWidget {
  const PlaySessionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: fitBlack,
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                  onPressed: () {
                    print('Chevron button pressed!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(color: Colors.lightBlue, width: 2),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: AutoSizeText(
                        'Title dev couché incliné',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: fitWeightSemiBold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        minFontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    child: Row(
                      children: List.generate(
                        10, // Nombre de boutons PlaySessionSetButton (modifiable)
                        (index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: PlaySessionSetButton(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
