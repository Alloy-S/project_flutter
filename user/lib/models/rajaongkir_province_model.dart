class RajaongkirProvince {
    Rajaongkir rajaongkir;

    RajaongkirProvince({
        required this.rajaongkir,
    });

}

class Rajaongkir {
    Query query;
    Status status;
    List<Result> results;

    Rajaongkir({
        required this.query,
        required this.status,
        required this.results,
    });

}

class Query {
    String key;

    Query({
        required this.key,
    });

}

class Result {
    String provinceId;
    String province;

    Result({
        required this.provinceId,
        required this.province,
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
