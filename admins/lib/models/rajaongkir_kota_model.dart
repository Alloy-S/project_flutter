class RajaongkirProvince {
    Rajaongkir rajaongkir;

    RajaongkirProvince({
        required this.rajaongkir,
    });

}

class Rajaongkir {
    Query query;
    Status status;
    List<ResultKota> results;

    Rajaongkir({
        required this.query,
        required this.status,
        required this.results,
    });

}

class Query {
    String province;

    Query({
        required this.province,
    });

}

class ResultKota {
    String cityId;
    String provinceId;
    String province;
    String type;
    String cityName;
    String postalCode;

    ResultKota({
        required this.cityId,
        required this.provinceId,
        required this.province,
        required this.type,
        required this.cityName,
        required this.postalCode,
    });

}

class Status {
    int code;
    String description;

    Status({
        required this.code,
        required this.description,
    });

}
