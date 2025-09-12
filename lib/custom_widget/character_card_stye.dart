// chart_card.dart
import 'package:flutter/material.dart';
import 'package:rick_and_morty_characters/model/character_data.dart';
import 'package:rick_and_morty_characters/utils/app_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CharacterCard extends StatefulWidget {
  final CharacterData character;
  final VoidCallback onFavoriteToggle;
  final bool isLoading;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoriteToggle,
    this.isLoading = false,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late bool _isFavorite = false;
  
  @override
  void initState() {
    super.initState();
     
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isLoading) {
      _scaleController.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isLoading) {
      _scaleController.reverse();
      widget.onFavoriteToggle();
    }
  }

  void _handleTapCancel() {
    if (!widget.isLoading) {
      _scaleController.reverse();
    }
  }

  Color _getStatusColor() {
    if (widget.isLoading) return Colors.grey[600]!;
    
    switch (widget.character.status.toLowerCase()) {
      case 'alive':
        return Colors.greenAccent[400]!;
      case 'dead':
        return Colors.redAccent[400]!;
      default:
        return Colors.grey[600]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.isLoading,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple[900]!,
                Colors.indigo[900]!,
                Colors.purple[800]!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: widget.isLoading
                            ? Container(
                                width: 100,
                                height: 100,
                                color: Colors.grey[400],
                              )
                            : FadeInImage(
                                placeholder: const AssetImage('assets/icons/placeholder.png'),
                                image: NetworkImage(widget.character.image),
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                fadeInDuration: const Duration(milliseconds: 300),
                              ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.character.name,
                            style: AppStyles.getAppTextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              context: context,
                              fontFamily: 'comic',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor().withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _getStatusColor(),
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              widget.isLoading ? "STATUS" : widget.character.status.toUpperCase(),
                              style: AppStyles.getAppTextStyle(
                                color: _getStatusColor(),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                context: context,
                                fontFamily: 'comic',
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          _textRow('Вид:', widget.character.species),
                          _textRow('Локация:', widget.character.location.name),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: widget.isLoading
                          ? Container(
                              width: 50,
                              height: 50,
                              color: Colors.grey[400],
                            )
                          : Image.asset(
                              _isFavorite
                                  ? 'assets/icons/ic_favoriteON.png'  
                                  : 'assets/icons/ic_favoriteOFF.png',
                              key: ValueKey(_isFavorite),
                              color: _isFavorite ? null : Colors.white,
                              width: 50,
                              height: 50,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: AppStyles.getAppTextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                context: context,
                fontFamily: 'comic',
              ),
            ),
            TextSpan(
              text: value,
              style: AppStyles.getAppTextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                context: context,
                fontFamily: 'comic',
              ),
            ),
          ],
        ),
      ),
    );
  }
}