class RajaongkirCost {
    RajaongkirCost({
        required this.rajaongkir,
    });

    final Rajaongkir? rajaongkir;

    factory RajaongkirCost.fromJson(Map<String, dynamic> json){ 
        return RajaongkirCost(
            rajaongkir: json["rajaongkir"] == null ? null : Rajaongkir.fromJson(json["rajaongkir"]),
        );
    }

}

class Rajaongkir {
    Rajaongkir({
        required this.query,
        required this.status,
        required this.originDetails,
        required this.destinationDetails,
        required this.results,
    });

    final Query? query;
    final Status? status;
    final NDetails? originDetails;
    final NDetails? destinationDetails;
    final List<Result2> results;

    factory Rajaongkir.fromJson(Map<String, dynamic> json){ 
        return Rajaongkir(
            query: json["query"] == null ? null : Query.fromJson(json["query"]),
            status: json["status"] == null ? null : Status.fromJson(json["status"]),
            originDetails: json["origin_details"] == null ? null : NDetails.fromJson(json["origin_details"]),
            destinationDetails: json["destination_details"] == null ? null : NDetails.fromJson(json["destination_details"]),
            results: json["results"] == null ? [] : List<Result2>.from(json["results"]!.map((x) => Result2.fromJson(x))),
        );
    }

}

class NDetails {
    NDetails({
        required this.cityId,
        required this.provinceId,
        required this.province,
        required this.type,
        required this.cityName,
        required this.postalCode,
    });

    final String? cityId;
    final String? provinceId;
    final String? province;
    final String? type;
    final String? cityName;
    final String? postalCode;

    factory NDetails.fromJson(Map<String, dynamic> json){ 
        return NDetails(
            cityId: json["city_id"],
            provinceId: json["province_id"],
            province: json["province"],
            type: json["type"],
            cityName: json["city_name"],
            postalCode: json["postal_code"],
        );
    }

}

class Query {
    Query({
        required this.origin,
        required this.destination,
        required this.weight,
        required this.courier,
    });

    final String? origin;
    final String? destination;
    final int? weight;
    final String? courier;

    factory Query.fromJson(Map<String, dynamic> json){ 
        return Query(
            origin: json["origin"],
            destination: json["destination"],
            weight: json["weight"],
            courier: json["courier"],
        );
    }

}

class Result2 {
    Result2({
        required this.code,
        required this.name,
        required this.costs,
    });

    final String? code;
    final String? name;
    final List<ResultCost> costs;

    factory Result2.fromJson(Map<String, dynamic> json){ 
        return Result2(
            code: json["code"],
            name: json["name"],
            costs: json["costs"] == null ? [] : List<ResultCost>.from(json["costs"]!.map((x) => ResultCost.fromJson(x))),
        );
    }

}

class ResultCost {
    ResultCost({
        required this.service,
        required this.description,
        required this.cost,
    });

    final String? service;
    final String? description;
    final List<CostCost> cost;

    factory ResultCost.fromJson(Map<String, dynamic> json){ 
        return ResultCost(
            service: json["service"],
            description: json["description"],
            cost: json["cost"] == null ? [] : List<CostCost>.from(json["cost"]!.map((x) => CostCost.fromJson(x))),
        );
    }

}

class CostCost {
    CostCost({
        required this.value,
        required this.etd,
        required this.note,
    });

    final int? value;
    final String? etd;
    final String? note;

    factory CostCost.fromJson(Map<String, dynamic> json){ 
        return CostCost(
            value: json["value"],
            etd: json["etd"],
            note: json["note"],
        );
    }

}

class Status {
    Status({
        required this.code,
        required this.description,
    });

    final int? code;
    final String? description;

    factory Status.fromJson(Map<String, dynamic> json){ 
        return Status(
            code: json["code"],
            description: json["description"],
        );
    }

}
