import '../models/user.dart';

final List<UserModel> fakeArtisans = [

  // =========================
  // PLOMBIERS
  // =========================

  UserModel(
    id: 1,
    firstName: "Ahmed",
    lastName: "Benali",
    phone: "0612345678",
    email: "ahmed@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Rabat",
    job: "Plombier",
    experience: "8 ans",
    description: "Spécialiste en plomberie sanitaire.",
    image: "",
  ),

  UserModel(
    id: 2,
    firstName: "Karim",
    lastName: "Tazi",
    phone: "0611111111",
    email: "karim@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Salé",
    job: "Plombier",
    experience: "5 ans",
    description: "Installation et dépannage.",
    image: "",
  ),

  UserModel(
    id: 3,
    firstName: "Youssef",
    lastName: "El Amrani",
    phone: "0622222222",
    email: "youssef@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Casablanca",
    job: "Plombier",
    experience: "10 ans",
    description: "Plomberie générale.",
    image: "",
  ),

    // =========================
  // ÉLECTRICIENS
  // =========================

  UserModel(
    id: 4,
    firstName: "Hamza",
    lastName: "Idrissi",
    phone: "0633333333",
    email: "hamza@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Marrakech",
    job: "Électricien",
    experience: "6 ans",
    description: "Installation électrique et maintenance.",
    image: "",
  ),

  UserModel(
    id: 5,
    firstName: "Mehdi",
    lastName: "Alaoui",
    phone: "0644444444",
    email: "mehdi@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Rabat",
    job: "Électricien",
    experience: "9 ans",
    description: "Expert en réseaux électriques.",
    image: "",
  ),

  UserModel(
    id: 6,
    firstName: "Anas",
    lastName: "Berrada",
    phone: "0655555555",
    email: "anas@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Tanger",
    job: "Électricien",
    experience: "4 ans",
    description: "Installation et dépannage électrique.",
    image: "",
  ),

    // =========================
  // PEINTRES
  // =========================

  UserModel(
    id: 7,
    firstName: "Soufiane",
    lastName: "Chraibi",
    phone: "0666666666",
    email: "soufiane@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Agadir",
    job: "Peintre",
    experience: "7 ans",
    description: "Peinture intérieure et extérieure.",
    image: "",
  ),

  UserModel(
    id: 8,
    firstName: "Ayoub",
    lastName: "El Fassi",
    phone: "0677777777",
    email: "ayoub@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Fès",
    job: "Peintre",
    experience: "5 ans",
    description: "Décoration et peinture moderne.",
    image: "",
  ),

  UserModel(
    id: 9,
    firstName: "Bilal",
    lastName: "Naciri",
    phone: "0688888888",
    email: "bilal@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Casablanca",
    job: "Peintre",
    experience: "11 ans",
    description: "Peinture professionnelle de bâtiments.",
    image: "",
  ),

    // =========================
  // MENUISIERS
  // =========================

  UserModel(
    id: 10,
    firstName: "Zakaria",
    lastName: "Lahlou",
    phone: "0691111111",
    email: "zakaria@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Meknès",
    job: "Menuisier",
    experience: "12 ans",
    description: "Fabrication de meubles sur mesure.",
    image: "",
  ),

  UserModel(
    id: 11,
    firstName: "Adil",
    lastName: "Benkirane",
    phone: "0692222222",
    email: "adil@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Rabat",
    job: "Menuisier",
    experience: "8 ans",
    description: "Menuiserie bois et aluminium.",
    image: "",
  ),

  UserModel(
    id: 12,
    firstName: "Othmane",
    lastName: "Saidi",
    phone: "0693333333",
    email: "othmane@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Oujda",
    job: "Menuisier",
    experience: "6 ans",
    description: "Installation de cuisines et placards.",
    image: "",
  ),

    // =========================
  // MAÇONS
  // =========================

  UserModel(
    id: 13,
    firstName: "Rachid",
    lastName: "Amrani",
    phone: "0694444444",
    email: "rachid@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Casablanca",
    job: "Maçon",
    experience: "15 ans",
    description: "Construction de maisons et villas.",
    image: "",
  ),

  UserModel(
    id: 14,
    firstName: "Ismail",
    lastName: "Haddad",
    phone: "0695555555",
    email: "ismail@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Marrakech",
    job: "Maçon",
    experience: "9 ans",
    description: "Travaux de gros œuvre et rénovation.",
    image: "",
  ),

  UserModel(
    id: 15,
    firstName: "Hicham",
    lastName: "Boussaid",
    phone: "0696666666",
    email: "hicham@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Salé",
    job: "Maçon",
    experience: "11 ans",
    description: "Maçonnerie traditionnelle et moderne.",
    image: "",
  ),

    // =========================
  // CLIMATISATION
  // =========================

  UserModel(
    id: 16,
    firstName: "Walid",
    lastName: "El Khatib",
    phone: "0697777777",
    email: "walid@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Rabat",
    job: "Climatisation",
    experience: "7 ans",
    description: "Installation et entretien de climatiseurs.",
    image: "",
  ),

  UserModel(
    id: 17,
    firstName: "Nabil",
    lastName: "Toumi",
    phone: "0698888888",
    email: "nabil@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Agadir",
    job: "Climatisation",
    experience: "10 ans",
    description: "Réparation et maintenance des systèmes de climatisation.",
    image: "",
  ),

  UserModel(
    id: 18,
    firstName: "Yassine",
    lastName: "El Malki",
    phone: "0699999999",
    email: "yassine@gmail.com",
    password: "123456",
    role: "artisan",
    city: "Casablanca",
    job: "Climatisation",
    experience: "5 ans",
    description: "Spécialiste en climatisation résidentielle.",
    image: "",
  ),


];

