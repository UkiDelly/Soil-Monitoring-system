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

String enumToPath(Plant plant) {
  switch (plant) {
    case Plant.rice:
      return "assets/plants/rice.png";

    case Plant.corn:
      return "assets/plants/cron.png";

    case Plant.cassava:
      return "assets/plants/cassava.png";

    default:
      break;
  }
  return "";
}
