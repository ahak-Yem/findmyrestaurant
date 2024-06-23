enum BrevoApiResponses{
  ok,
  created,
  accepted,
  noContent,
  badRequest,
  unauthorized,
  paymentRequired,
  forbidden,
  notFound,
  methodNotAllowed,
  notAcceptable,
  tooManyRequests;
}

extension BrevoApiResponsesExtension on BrevoApiResponses{
  int get responseCode{
    switch(this){
      case BrevoApiResponses.ok:
        return 200;
      case BrevoApiResponses.created:
        return 201;
      case BrevoApiResponses.accepted:
        return 202;
      case BrevoApiResponses.noContent:
        return 204;
      case BrevoApiResponses.badRequest:
        return 400;
      case BrevoApiResponses.unauthorized:
        return 401;
      case BrevoApiResponses.paymentRequired:
        return 402;
      case BrevoApiResponses.forbidden:
        return 403;
      case BrevoApiResponses.notFound:
        return 404;
      case BrevoApiResponses.methodNotAllowed:
        return 405;
      case BrevoApiResponses.notAcceptable:
        return 406;
      case BrevoApiResponses.tooManyRequests:
        return 429;      
    }
  }

  bool get isSuccess {
    return this == BrevoApiResponses.ok ||
        this == BrevoApiResponses.created ||
        this == BrevoApiResponses.accepted ||
        this == BrevoApiResponses.noContent;
  }

  static BrevoApiResponses mapCodeToBrevoApiResponses(int statusCode) {
    switch (statusCode) {
      case 200:
        return BrevoApiResponses.ok;
      case 201:
        return BrevoApiResponses.created;
      case 202:
        return BrevoApiResponses.accepted;
      case 204:
        return BrevoApiResponses.noContent;
      case 400:
        return BrevoApiResponses.badRequest;
      case 401:
        return BrevoApiResponses.unauthorized;
      case 402:
        return BrevoApiResponses.paymentRequired;
      case 403:
        return BrevoApiResponses.forbidden;
      case 404:
        return BrevoApiResponses.notFound;
      case 405:
        return BrevoApiResponses.methodNotAllowed;
      case 406:
        return BrevoApiResponses.notAcceptable;
      case 429:
        return BrevoApiResponses.tooManyRequests;
      default:
        return BrevoApiResponses.badRequest;
    }
  }

  // TODO: Create a getter that returns handling workflow
}