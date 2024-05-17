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

  // TODO: Create a getter that returns handling workflow
}