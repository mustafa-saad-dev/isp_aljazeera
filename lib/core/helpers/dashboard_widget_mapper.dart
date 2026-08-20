import 'package:flutter/material.dart';

class DashboardWidgetMapper {
  DashboardWidgetMapper._();

  static const Map<String, IconData> _iconMap = {
    'fa-users': Icons.people_alt_outlined,
    'fa-user': Icons.person_outlined,
    'fa-user-check': Icons.how_to_reg_outlined,
    'fa-user-clock': Icons.schedule_outlined,
    'fa-user-times': Icons.person_off_outlined,
    'fa-wifi': Icons.wifi_outlined,
    'fa-wallet': Icons.account_balance_wallet_outlined,
    'fa-star': Icons.star_outline_rounded,
    'fa-gift': Icons.card_giftcard_outlined,
    'fa-coins': Icons.monetization_on_outlined,
    'fa-chart-bar': Icons.bar_chart_outlined,
    'fa-chart-line': Icons.show_chart_outlined,
    'fa-chart-pie': Icons.pie_chart_outline,
    'fa-receipt': Icons.receipt_long_outlined,
    'fa-file-invoice-dollar': Icons.request_quote_outlined,
    'fa-credit-card': Icons.credit_card_outlined,
    'fa-money-bill-wave': Icons.payments_outlined,
    'fa-server': Icons.dns_outlined,
    'fa-network-wired': Icons.device_hub_outlined,
    'fa-desktop': Icons.computer_outlined,
    'fa-hdd': Icons.storage_outlined,
    'fa-bolt': Icons.bolt_outlined,
    'fa-clock': Icons.access_time_outlined,
    'fa-calendar': Icons.calendar_today_outlined,
    'fa-cog': Icons.settings_outlined,
    'fa-bell': Icons.notifications_outlined,
    'fa-envelope': Icons.mail_outline,
    'fa-phone': Icons.phone_outlined,
    'fa-map-marker-alt': Icons.location_on_outlined,
    'fa-shopping-cart': Icons.shopping_cart_outlined,
    'fa-box': Icons.inventory_2_outlined,
    'fa-ticket-alt': Icons.confirmation_num_outlined,
    'fa-headset': Icons.headset_mic_outlined,
  };

  static const Map<String, Color> _colorMap = {
    'bg-primary': Color(0xFF4338CA),
    'bg-secondary': Color(0xFF5C6FC0),
    'bg-success': Color(0xFF4CAF72),
    'bg-info': Color(0xFF29A3CD),
    'bg-warning': Color(0xFFF0B429),
    'bg-danger': Color(0xFFEF5F5F),
    'bg-purple': Color(0xFF7C3AED),
    'bg-pink': Color(0xFFEC6A95),
    'bg-octonary': Color(0xFF5C6FC0),
    'bg-cyan': Color(0xFF29A3CD),
    'bg-indigo': Color(0xFF5C6FC0),
    'bg-teal': Color(0xFF14B8A6),
  };

  static IconData icon(String? iconName, {IconData fallback = Icons.dashboard_outlined}) {
    if (iconName == null || iconName.isEmpty) return fallback;
    return _iconMap[iconName] ?? fallback;
  }

  static Color color(String? colorName, {required bool isDark}) {
    if (colorName == null || colorName.isEmpty) {
      return isDark ? const Color(0xFF6366F1) : const Color(0xFF4338CA);
    }
    return _colorMap[colorName] ?? (isDark ? const Color(0xFF6366F1) : const Color(0xFF4338CA));
  }
}
