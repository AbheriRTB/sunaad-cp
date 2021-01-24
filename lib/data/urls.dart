class Urls {
  // getPrograms from Heroku
  String program() {
    return 'https://sunaad-services-njs.herokuapp.com/getPrograms';
  }

  // getArtiste from Heroku
  String artiste() {
    return 'https://sunaad-services-njs.herokuapp.com/getArtiste/';
  }

// getArtiste from Heroku
  String venue() {
    return 'https://sunaad-services-njs.herokuapp.com/getVenue/';
  }

  // Images from Python anywhere
  String image() {
    return 'https://abheri.pythonanywhere.com/static/images/';
  }

  // Default artist Image from Python anywhere
  String defaultArtisteImage() {
    return 'https://abheri.pythonanywhere.com/static/images/default2.jpg';
  }
}
