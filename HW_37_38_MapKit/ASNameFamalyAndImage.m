//
//  ASNameFamalyAndImage.m
//  HW_37_38_MapKit
//
//  Created by MD on 11.07.15.
//  Copyright (c) 2015 MD. All rights reserved.
//

#import "ASNameFamalyAndImage.h"

@implementation ASNameFamalyAndImage

- (instancetype) init
{
    self = [super init];
    if (self) {
        
        self.arrayImages = @[@"male3-20.png",          @"male3-32.png",          @"male3-48.png",          @"male3-64.png",
                             @"malecostume-20.png",    @"malecostume-24.png",    @"malecostume-32.png",    @"malecostume-48.png",     @"malecostume-64.png",
                             @"female1-24.png",        @"female1-32.png",        @"female1-48.png",        @"female1-64.png",
                             @"Army_officer24.png",    @"Army_officer-32.png",   @"Army_officer-48.png",   @"Army_officer-64.png",
                             @"Themis24.png",          @"Themis-32.png",         @"Themis-48.png",         @"Themis-64.png"];
        
        self.arrayNames = @[@"Aaron",     @"Abdiel",     @"Abdullah",  @"Abel",       @"Abraham",   @"Abram",
                            @"Adam",      @"Adan",       @"Addison",   @"Aden",       @"Aditya",    @"Adolfo",
                            @"Adonis",    @"Adrian",     @"Adriel",    @"Adrien",     @"Agustin",   @"Ahmad",
                            @"Aidan",     @"Alan",       @"Albert",    @"Alden",      @"Aldo",      @"Alec",
                            @"Alejandro", @"Alessandro", @"Alex",      @"Alexander",  @"Alexandro", @"Alexis",
                            @"Alexzander",@"Alfonso",    @"Alfred",    @"Ali",        @"Alijah",    @"Allan",
                            @"Alonso",    @"Amari",      @"Amarion",   @"Amir",       @"Anderson",  @"Andre",
                            @"Andres",    @"Andrew",     @"Andy",      @"Angel",      @"Angelo",    @"Anthony",
                            @"Anthony",   @"Antoine",    @"Anton",     @"Antonio",    @"Antony",    @"Antwan",
                            @"Ari",       @"Ariel",      @"Arjun",     @"Armando",    @"Armani",    @"Arnold",
                            @"Aron",      @"Arthur",
                            @"Arturo",    @"Aryan",     @"Asa",         @"Asher",     @"Ashton",    @"Aubrey",
                            @"August",    @"Augustus",  @"Austen",      @"Austin",    @"Austyn",    @"Avery",
                            @"Axel",      @"Ayden",     @"Baby",        @"Bailey",    @"Barrett",   @"Barry",
                            @"Beau",      @"Ben",       @"Benjamin",    @"Bennett",   @"Benny",     @"Bernard",
                            @"Bernardo",  @"Bilal",     @"Billy",       @"Blaine",
                            @"Blaise",    @"Blake",     @"Blaze",       @"Bo",          @"Bobby",   @"Brad",@"Braden",
                            @"Bradley",   @"Brady",     @"Bradyn",      @"Braeden",     @"Braedon", @"Braiden",
                            @"Branden",   @"Brandon",   @"Braulio",     @"Braxton",     @"Brayan",  @"Brayden",
                            @"Braydon", @"Brendan",     @"Brenden",     @"Brendon",     @"Brennan", @"Brennen",
                            @"Brent",   @"Brenton",     @"Bret",        @"Brett",       @"Brian",   @"Brice",@"Brock",
                            @"Brodie",  @"Brody",       @"Brooks",      @"Bruce",       @"Bruno",   @"Bryan",@"Bryant",
                            @"Bryce",   @"Brycen",       @"Bryson",     @"Byron",       @"Cade",    @"Caden",@"Cael",
                            @"Caiden",  @"Cale",        @"Caleb",       @"Calvin",      @"Camden",  @"Cameron",@"Camren",
                            @"Camron",  @"Carl",        @"Carlo",       @"Carlos",      @"Carlton", @"Carson",@"Carter",
                            @"Casey",   @"Cason",       @"Cayden",      @"Cedric",      @"Cesar",   @"Chad",@"Chaim",@"Chance",
                            @"Chandler",  @"Charles",   @"Charlie",     @"Chase",       @"Chaz",    @"Chris",@"Christian",
                            @"Christopher",@"Clarence", @"Clark",       @"Clay",        @"Clayton", @"Clifford",@"Clifton",
                            @"Clinton", @"Coby",        @"Cody",        @"Colby",       @"Cole",    @"Coleman",@"Colin",
                            @"Collin",  @"Colt",        @"Colten",      @"Colton",      @"Conner",  @"Conor",@"Conrad",
                            @"Cooper",  @"Corbin",      @"Cordell",     @"Corey",       @"Cornelius",@"Cortez",@"Cory",
                            @"Craig",   @"Cristian",    @"Cristobal",   @"Cristopher",  @"Cruz",    @"Cullen",@"Curtis",
                            @"Cyrus",   @"Dakota",      @"Dale",@"Dallas",@"Dallin",    @"Dalton",
                            
                            @"Damian",  @"Damien",  @"Damion",@"Damon",@"Dandre",@"Dane",
                            @"Dangelo", @"Daniel",  @"Danny",@"Dante",@"Daquan",@"Darian",
                            @"Darien",  @"Darin",   @"Dario",@"Darion",@"Darius",@"Darnell",
                            @"Darrell", @"Darren",  @"Darrin",@"Darrion",@"Darrius",@"Darryl",
                            @"Darwin",  @"Daryl",   @"Dashawn",@"David",@"Davin",@"Davion",
                            @"Davis",   @"Davon",   @"Dawson",@"Dayton",@"Dean",@"Deandre",
                            @"Deangelo",@"Declan",  @"Demarcus",@"Demetrius",@"Dennis",
                            @"Denzel",  @"Deon",    @"Deonte",@"Derek",@"Derick",@"Derrick",
                            @"Deshaun", @"Deshawn", @"Desmond",@"Destin",@"Devan",@"Devante",
                            @"Deven",   @"Devinv",  @"Devon",@"Devonte",@"Devyn",@"Dexter",@"Diego",
                            @"Dillan",  @"Dillon",  @"Dimitri",@"Dion",@"Domenic",@"Dominic",
                            @"Dominick",@"Dominik"  ,@"Dominique",@"Donald",@"Donavan",
                            @"Donovan", @"Dontae",  @"Donte",@"Dorian",@"Douglas",@"Drake",
                            @"Draven",  @"Drew",    @"Duane",@"Duncan",@"Dustin",@"Dwayne",
                            @"Dwight",  @"Dylan",   @"Dylon",@"Ean",@"Earl",@"Easton",
                            @"Eddie",   @"Eddy",    @"Edgar",@"Edgardo",@"Eduardo",@"Edward",
                            @"Edwin",   @"Efrain",  @"Efren",@"Eli",@"Elian",@"Elias",
                            @"Eliezer", @"Elijah",  @"Eliseo",@"Elisha",@"Elliot",@"Elliott",
                            @"Ellis",   @"Elmer",   @"Elvin",@"Elvis",@"Emanuel",@"Emerson",
                            @"Emiliano",@"Emilio",  @"Emmanuel",@"Emmett",@"Enrique",
                            @"Eric",    @"Erick",   @"Erik",@"Ernest",@"Ernesto",@"Esteban",
                            @"Estevan", @"Ethan",   @"Ethen",@"Eugene",@"Evan",@"Everett",
                            @"Ezekiel", @"Ezequiel",@"Ezra",@"Fabian",@"Felipe",@"Felix",
                            @"Fernando",@"Fidel",   @"Finn",@"Forrest",@"Francis",@"Francisco",
                            @"Frank",   @"Frankie", @"Franklin",@"Fred",@"Freddie",@"Freddy",
                            @"Frederick",@"Fredrick",@"Gabriel",@"Gael",@"Gage",
                            @"Gaige",   @"Gannon",  @"Garett",@"Garret",@"Garrettv",@"Garrison",
                            @"Gary",    @"Gaven",   @"Gavin",@"Gavyn",@"Geoffrey",@"George",@"Gerald",
                            @"Gerard",  @"Gerardo", @"German",@"Gian",@"Giancarlo",@"Gianni",
                            @"Gideon",  @"Gilbert", @"Gilberto",@"Gino",@"Giovanni",@"Giovanny",
                            @"Glen",    @"Glenn",   @"Gonzalo",@"Gordon",@"Grady",@"Graham",
                            @"Grant",   @"Grayson", @"Gregory",@"Greyson",@"Griffin",
                            @"Guadalupe",@"Guillermo",@"Gunnar",@"Gunner",@"Gustavo",@"Guy",
                            @"Haden",   @"Hamza",   @"Harley",@"Harold",@"Harrison",@"Harry",
                            @"Hassan",  @"Hayden",  @"Heath",@"Hector",@"Henry",@"Herbert",
                            @"Heriberto",@"Holden", @"Houston",@"Howard",@"Hudson",
                            @"Hugh",    @"Hugo",    @"Humberto",@"Hunter",@"Ian",@"Ibrahim",
                            @"Ignacio", @"Immanuel",@"Irvin",@"Irving",@"Isaac",@"Isaak",
                            @"Isai",    @"Isaiah",  @"Isaias",@"Isiah",@"Ismael",@"Israel",
                            @"Issac",   @"Ivan",    @"Izaiah",@"Jabari",@"Jace",@"Jack",
                            @"Jackson", @"Jacob",   @"Jacoby",@"Jaden",@"Jadon",@"Jadyn",
                            @"Jaeden",  @"Jagger",  @"Jaheem",@"Jaheim",@"Jahiem",@"Jaiden",
                            @"Jaime",   @"Jair",    @"Jairo",@"Jake",@"Jakob",@"Jakobe",@"Jalen",
                            @"Jamal",   @"Jamar",   @"Jamari",@"Jamel",@"James",@"Jameson",
                            @"Jamie",   @"Jamil",   @"Jamir",@"Jamison",@"Jan",@"Jaquan",
                            @"Jaquez",  @"Jared",   @"Jaren",@"Jarod",@"Jaron",@"Jarred",
                            @"Jarrett", @"Jarrod",  @"Jarvis",@"Jase",@"Jason",@"Jasper",
                            @"Javen",   @"Javier",  @"Javion",@"Javon",@"Jaxon",@"Jaxson",
                            
                            
                            @"Jay",@"Jayce",@"Jayden",@"Jaydon",@"Jaylan",@"Jaylen",
                            @"Jaylin",@"Jaylon",@"Jayson",@"Jean",@"Jeff",@"Jefferson",
                            @"Jeffery",@"Jeffrey",@"Jeremiah",@"Jeremy",@"Jermaine",
                            @"Jerome",@"Jerry",@"Jesse",@"Jessie",@"Jesus",@"Jett",
                            @"Jevon",@"Jimmy",@"Joan",@"Joaquin",@"Joe",@"Joel",
                            @"Joey",@"Johan",@"John",@"Johnathan",@"Johnathon",
                            @"Johnny",@"Jon",@"Jonah",@"Jonas",@"Jonatan",@"Jonathan",
                            @"Jonathon",@"Jordan",@"Jorden",@"Jordon",@"Jordy",@"Jorge",
                            @"Jose",@"Josef",@"Joseph",@"Josh",@"Joshua",@"Josiah",@"Josue",
                            @"Jovan",@"Jovani",@"Jovany",@"Juan",@"Judah",@"Jude",@"Julian",
                            @"Julien",@"Julio",@"Julius",@"Junior",@"Justice",@"Justin",
                            @"Justus",@"Justyn",@"Kade",@"Kaden",@"Kadin",@"Kai",@"Kaiden",
                            @"Kale",@"Kaleb",@"Kameron",@"Kamron",@"Kane",@"Kareem",@"Karl",
                            @"Karson",@"Kasey",@"Kayden",@"Keagan",@"Keanu",@"Keaton",@"Keegan",
                            @"Keenan",@"Keith",@"Kellen",@"Kelly",@"Kelton",@"Kelvin",@"Kendall",
                            @"Kendrick",@"Kennedy",@"Kenneth",@"Kenny",@"Kent",@"Kenyon",@"Keon",
                            @"Keshawn",@"Keven",@"Kevin",@"Kevon",@"Keyon",@"Keyshawn",@"Khalid",
                            @"Khalil",@"Kian",@"Kieran",@"Kirk",@"Kobe",@"Koby",@"Kody",@"Kolby",
                            @"Kole",@"Kolton",@"Korbin",@"Korey",@"Kory",@"Kristian",@"Kristofer",
                            @"Kristopher",@"Kurt",@"Kurtis",@"Kylan",@"Kyle",@"Kyler",@"Kyree",
                            @"Lamar",@"Lamont",@"Lance",@"Landen",@"Landon",@"Lane",@"Larry",
                            @"Latrell",@"Lawrence",@"Lawson",@"Layne",@"Layton",@"Lee",@"Leo",
                            @"Leon",@"Leonard",@"Leonardo",@"Leonel",@"Leroy",@"Levi",@"Lewis",
                            @"Liam",@"Lincoln",@"Lisandro",@"Logan",@"London",@"Lonnie",@"Lorenzo",
                            @"Louis",@"Luc",@"Luca",@"Lucas",@"Luciano",@"Luis",@"Lukas",@"Luke",
                            @"Malachi",@"Malakai",@"Malcolm",@"Malik",@"Manuel",@"Marc",@"Marcel",
                            @"Marcelo",@"Marco",@"Marcos",@"Marcus",@"Mariano",@"Mario",@"Mark",
                            @"Markus",@"Marlon",@"Marquez",@"Marquis",@"Marquise",@"Marshall",
                            @"Martin",@"Marvin",@"Mason",@"Mateo",@"Mathew",@"Matteo",@"Matthew",
                            @"Maurice",@"Mauricio",@"Maverick",@"Max",@"Maxim",@"Maximilian",
                            @"Maximillian",@"Maximo",@"Maximus",@"Maxwell",@"Mekhi",@"Melvin",
                            @"Micah",@"Michael",@"Micheal",@"Miguel",@"Mike",@"Mikel",@"Miles",
                            @"Milo",@"Milton",@"Misael",@"Mitchel",@"Mitchell",@"Mohamed",
                            @"Mohammad",@"Mohammed",@"Moises",@"Morgan",@"Moses",@"Moshe",
                            @"Muhammad",@"Mustafa",@"Myles",@"Nash",@"Nasir",@"Nathan",
                            @"Nathanael",@"Nathanial",@"Nathaniel",@"Nathen",@"Neal",
                            @"Nehemiah",@"Neil",@"Nelson",@"Nestor",@"Nicholas",@"Nick",
                            @"Nickolas",@"Nico",@"Nicolas",@"Nigel",@"Nikhil",@"Nikolas",
                            @"Noah",@"Noe",@"Noel",@"Nolan",@"Norman",@"Octavio",@"Oliver",
                            @"Omar",@"Omari",@"Omarion",@"Orion",@"Orlando",@"Osbaldo",
                            @"Oscar",@"Osvaldo",@"Oswaldo",@"Owen",@"Pablo",@"Parker",
                            @"Patrick",@"Paul",@"Paxton",@"Payton",@"Pedro",@"Perry",
                            @"Peter",@"Peyton",@"Philip",@"Phillip",@"Phoenix",@"Pierce",
                            @"Pierre",@"Porter",@"Pranav",@"Preston",@"Prince",@"Quentin",
                            @"Quincy",@"Quinn",@"Quinten",@"Quintin",@"Quinton",@"Rafael",
                            @"Rahul",@"Ralph",@"Ramiro",@"Ramon",@"Randall",@"Randy",
                            @"Raphael",@"Rashad",@"Raul",@"Ray",@"Raymond",@"Raymundo",
                            @"Reagan",@"Reece",@"Reed",@"Reese",@"Reginald",@"Reid",
                            @"Reilly",@"Remington",@"Rene",@"Reuben",@"Rey",@"Reynaldo",
                            @"Rhett",@"Ricardo",@"Richard",@"Rickey",@"Ricky",@"Rigoberto",
                            @"Riley",@"River",@"Robert",@"Roberto",@"Rocco",@"Roderick",
                            @"Rodney",@"Rodolfo",@"Rodrigo",@"Rogelio",@"Roger",@"Rohan",
                            @"Roland",@"Rolando",@"Roman",@"Romeo",@"Ronald",@"Ronaldo",
                            @"Ronan",@"Ronnie",@"Rory",@"Ross",@"Rowan",@"Roy",@"Ruben",
                            @"Rudy",@"Russell",@"Ryan",@"Ryder",@"Rylan",@"Rylee",
                            @"Ryley",@"Sabastian",@"Sage",@"Salvador",@"Salvatore",
                            @"Sam",@"Samir",@"Sammy",@"Samson",@"Samuel",@"Santiago",
                            @"Santino",@"Santos",@"Saul",@"Savion",@"Sawyer",
                            @"Scott",@"Seamus",@"Sean",@"Sebastian",@"Semaj",@"Sergio",
                            @"Seth",@"Shamar",@"Shane",@"Shannon",@"Shaun",@"Shawn",
                            @"Shayne",@"Shea",@"Sheldon",@"Shemar",@"Sidney",@"Silas",
                            @"Simon",@"Sincere",@"Skylar",@"Skyler",@"Solomon",@"Sonny",
                            @"Spencer",@"Stanley",@"Stefan",@"Stephan",@"Stephen",@"Stephon",
                            @"Sterling",@"Steve",@"Steven",@"Stone",@"Stuart",@"Sullivan",
                            @"Syed",@"Talon",@"Tanner",@"Tariq",@"Tate",@"Tavion",
                            @"Taylor",@"Terrance",@"Terrell",@"Terrence",@"Terry",@"Thaddeus",
                            @"Theodore",@"Thomas",@"Timothy",@"Titus",@"Tobias",@"Toby",
                            @"Todd",@"Tomas",@"Tommy",@"Tony",@"Trace",@"Travis",@"Travon",
                            @"Tre",@"Trent",@"Trenton",@"Trever",@"Trevin",@"Trevion",
                            @"Trevon",@"Trevor",@"Trey",@"Treyton",@"Tristan",@"Tristen",
                            @"Tristian",@"Tristin",@"Triston",@"Troy",@"Trystan",@"Tucker",
                            @"Turner",@"Ty",@"Tyler",@"Tylor",@"Tyree",@"Tyrell",
                            @"Tyrese",@"Tyrone",@"Tyshawn",@"Tyson",@"Ulises",@"Ulysses",@"Uriel",
                            @"Vance",@"Vaughn",@"Vernon",@"Vicente",@"Victor",@"Vincent",@"Wade",
                            @"Walker",@"Walter",@"Warren",@"Waylon",@"Wayne",@"Wesley",@"Weston",
                            @"Will",@"William",@"Willie",@"Wilson",@"Winston",@"Wyatt",@"Xander",
                            @"Xavier",@"Xzavier",@"Yadiel",@"Yahir",@"Yosef",@"Zachariah",@"Zachary",
                            @"Zachery",@"Zack",@"Zackary",@"Zackery",@"Zain",@"Zaire",@"Zakary",
                            @"Zander",@"Zane",@"Zavier",@"Zayne",@"Zechariah",@"Zion"];
        
        
        self.arrayFamaly = @[ @"SMITH",     @"JOHNSON", @"WILLIAMS",    @"JONES",   @"BROWN",   @"DAVIS",   @"MILLER",  @"WILSON",  @"MOORE",
                              @"TAYLOR",    @"ANDERSON",@"THOMAS",      @"JACKSON", @"WHITE",   @"HARRIS",  @"MARTIN",  @"THOMPSON",@"GARCIA",
                              @"MARTINEZ",  @"GREEN",   @"STEWART",     @"PETERSON",@"JAMES",   @"WATSON",  @"BROOKS",  @"KELLY",   @"SANDERS",
                              @"ROBINSON",  @"ADAMS",   @"SANCHEZ",     @"GRAY",    @"RAMIREZ", @"PRICE",   @"BENNETT", @"WOOD",    @"BARNES",
                              @"CLARK",     @"BAKER",   @"MORRIS",      @"ROSS",    @"HENDERSON",@"HENDERSON",@"PATTERSON",@"HUGHES",@"FLORES",
                              @"RODRIGUEZ", @"GONZALEZ",@"ROGERS",      @"JENKINS", @"PERRY",   @"POWELL",  @"LONG",    @"WASHINGTON",@"BUTLER",
                              @"LEWIS",     @"NELSON",  @"REED",        @"SIMMONS", @"HAMILTON",@"HARRISON",@"CRUZ",    @"MARSHALL",  @"ORTIZ",
                              @"LEE",       @"CARTER",  @"COOK",        @"FOSTER",  @"GRAHAM",  @"GIBSON",  @"MCDONALD",@"DUNN",    @"PERKINS",
                              @"WALKER",    @"MITCHELL",@"MORGAN",      @"GONZALES",@"SULLIVAN",@"GOMEZ",   @"FREEMAN", @"NICHOLS", @"GRANT",
                              @"HALL",      @"PEREZ",   @"BELL",        @"BAILEY",  @"WALLACE", @"MURRAY",  @"WELLS",   @"MILLS",   @"KNIGHT",
                              @"ALLEN",     @"ROBERTS", @"MURPHY",      @"BRYANT",  @"WOODS",   @"WEBB",    @"ROBERTSON",@"PALMER", @"FERGUSON",
                              @"YOUNG",     @"TURNER",  @"RIVERA",      @"ALEXANDER",@"COLE",   @"SIMPSON", @"HUNT",    @"DANIELS", @"ROSE",
                              @"HERNANDEZ", @"PHILLIPS",@"COOPER",      @"RUSSELL", @"WEST",    @"STEVENS", @"RICE",    @"BLACK",   @"STONE",
                              @"KING",      @"CAMPBELL",@"RICHARDSON",  @"GRIFFIN", @"JORDAN",  @"TUCKER",  @"BURNS",   @"SHAW",    @"HOLMES",
                              @"WRIGHT",    @"PARKER",  @"COX",         @"DIAZ",    @"OWENS",   @"PORTER",  @"REYES",   @"GORDON",  @"HAWKINS",
                              @"LOPEZ",     @"EVANS",   @"HOWARD",      @"HAYES",   @"REYNOLDS",@"HUNTER",  @"WARREN",  @"DIXON",   @"RAMOS",
                              @"HILL",      @"EDWARDS", @"WARD",        @"MYERS",   @"FISHER",  @"HICKS",   @"MASON",   @"MORALES", @"KENNEDY",
                              @"SCOTT",     @"COLLINS", @"TORRES",      @"FORD",    @"ELLIS",   @"CRAWFORD",@"CRAWFORD",@"HENRY",   @"BOYD"];
    }
    return self;
}


@end
