enum Categories { Paper, E_WASTE, METALS, PLASTIC, Other }

extension CategoryName on Categories {
  String get displayName {
    switch (this) {
      case Categories.E_WASTE:
        return 'E-Waste';
      case Categories.METALS:
        return 'Metals';
      case Categories.PLASTIC:
        return 'Plastic';
      case Categories.Paper:
        return "Paper";
      case Categories.Other:
        return "other";
    }
  }
}

enum UnitType { kg, pcs }

extension UnitTypeName on UnitType {
  String get name {
    switch (this) {
      case UnitType.kg:
        return 'kg';
      case UnitType.pcs:
        return 'pcs';
    }
  }
}

enum PickupStatus { PENDING, ACCEPTED, COMPLETED, CANCELLED, REJECTED }

extension PickupStatusName on PickupStatus {
  String get status {
    switch (this) {
      case PickupStatus.PENDING:
        return "pending";
      case PickupStatus.ACCEPTED:
        return "accepted";

      case PickupStatus.COMPLETED:
        return "completed";

      case PickupStatus.CANCELLED:
        return "cancelled";

      case PickupStatus.REJECTED:
        return "rejected";
    }
  }

  static PickupStatus fromString(String status) {
    switch (status) {
      case "pending":
        return PickupStatus.PENDING;
      case "accepted":
        return PickupStatus.ACCEPTED;
      case "completed":
        return PickupStatus.COMPLETED;
      case "cancelled":
        return PickupStatus.CANCELLED;
      case "rejected":
        return PickupStatus.REJECTED;
      default:
        throw ArgumentError("Unknown pickup status: $status");
    }
  }
}
