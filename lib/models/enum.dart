enum Plant { rice, corn, cassava, none }

String enumToString(Plant plant) {
  switch (plant) {
    case Plant.rice:
      return "rice";

    case Plant.corn:
      return "corn";

    case Plant.cassava:
      return "cassava";

    default:
      break;
  }
  return "";
}

Plant stringToEnum(String plant) {
  switch (plant) {
    case "rice":
      return Plant.rice;

    case "corn":
      return Plant.corn;

    case "cassava":
      return Plant.cassava;

    default:
      break;
  }
  return Plant.none;
}
