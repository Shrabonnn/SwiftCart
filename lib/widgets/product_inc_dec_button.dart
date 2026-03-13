
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ProductQuantityIncDecButton extends StatefulWidget {
  const ProductQuantityIncDecButton({super.key, required this.onChange, required this.quantity});

  final int quantity;
  final Function(int) onChange;

  @override
  State<ProductQuantityIncDecButton> createState() => _ProductQuantityIncDecButtonState();
}

class _ProductQuantityIncDecButtonState extends State<ProductQuantityIncDecButton> {
  late int _count;
  final double total = 0 ;

  @override
  void initState() {
    super.initState();
    _count = widget.quantity; // Start with initial quantity
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildIconButton(icon: Icon(Icons.remove,color: Colors.black),onTap: (){
          if (_count > 1) {
            setState(() {
              _count--;
            });
            widget.onChange(_count); // Send updated value back
          }

        },),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${_count}',style: TextStyle(fontSize: 18),),
        ),
        _buildIconButton(icon: Icon(Icons.add,color: Colors.black,),onTap: (){
          if (_count < 20) {
            setState(() {
              _count++;
            });
            widget.onChange(_count); // Send updated value back
          }
        },),

      ],
    );
  }
}

class _buildIconButton extends StatelessWidget {
  const _buildIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.cartBackground,
            borderRadius: BorderRadiusGeometry.circular(4)
        ),
        child: IconButton(onPressed: onTap,
          icon: icon,
          color: Colors.white,
          padding: EdgeInsets.zero,
          alignment: AlignmentGeometry.center,),
      ),
    );
  }
}