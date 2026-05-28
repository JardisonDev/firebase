import 'package:flutter/material.dart';

import 'package:inspector_ro/core/theme/app_colors.dart';

import 'package:inspector_ro/models/checklist_item_model.dart';

class ChecklistItemTile extends StatelessWidget {
  final ChecklistItemModel item;

  final Function(String status) onChanged;

  const ChecklistItemTile({
    super.key,

    required this.item,

    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOk = item.status == 'ok';

    final bool isAtencao = item.status == 'atencao';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(6),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: AppColors.gray2, width: 1),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          //const SizedBox(width: 12),

          // TEXTO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  item.titulo,

                  style: const TextStyle(
                    fontFamily: 'Inter',

                    color: AppColors.primaryText,

                    fontSize: 16,

                    fontWeight: FontWeight.normal,
                  ),
                ),

                //const SizedBox(height: 4),
                Text(
                  item.descricao,

                  style: TextStyle(
                    fontFamily: 'Inter',

                    fontSize: 10,
                    fontWeight: FontWeight.normal,

                    color: AppColors.gray5,
                  ),
                ),
              ],
            ),
          ),

          // BOTÕES
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // OK
              GestureDetector(
                onTap: () {
                  onChanged('ok');
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: isOk ? AppColors.manutencao : Colors.white,

                    borderRadius: BorderRadius.circular(12),

                    border: Border.all(color: AppColors.manutencao),
                  ),

                  child: Text(
                    'OK',

                    style: TextStyle(
                      fontFamily: 'Inter',

                      fontWeight: FontWeight.w700,

                      color: isOk ? Colors.white : AppColors.manutencao,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // ATENÇÃO
              GestureDetector(
                onTap: () {
                  onChanged('atencao');
                },

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    color: isAtencao ? AppColors.emOperacao : Colors.white,

                    borderRadius: BorderRadius.circular(12),

                    border: Border.all(color: AppColors.emOperacao),
                  ),

                  child: Text(
                    'Atenção',

                    style: TextStyle(
                      fontFamily: 'Inter',

                      fontWeight: FontWeight.w700,

                      color: isAtencao ? Colors.white : AppColors.emOperacao,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
