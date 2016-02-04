
// Speech Synthesis using Kevin - the voice of FreeTTS

// NOTE:
// There may be better options if you want a voice that sounds more human-like...
// If you are on OSX, have a look at the "say" command: 
// exec("say", "This is OSX speaking.");
// On windows the "ptts" command should do the trick ...


import voce.*;

// text to be spoken
String txt = "";


void setup() {
  
  String libraryPath = getLibraryPath();
  voce.SpeechInterface.init(libraryPath, true, false, "", "");

  // println("This is Kevin from FreeTTS speaking.");
  // textToSpeech("This is Kevin from FreeTTS speaking.");
  
  // println("This is OSX speaking.");
  // exec("say", "This is OSX speaking.");
  
  // println("This is Zarvox on OSX.");
  // exec("say", "-v", "Zarvox", "This is Zarvox on OSX.");
  
  println("Type a message followed by RETURN to hear it spoken aloud.");
  println("Type DELETE to stop speaking.");
  
}


void draw() {
}


void keyPressed() {
  
  switch(key) {
             
    // speak the current sentence
    case RETURN:
    case ENTER:
      println();
      textToSpeech(txt);
      txt = "";
      break;
      
    // stop speaking
    case BACKSPACE:
    case DELETE:
      silence();
      break;
     
    // assemble letters
    default:
      if(key != CODED) {
        print(key);
        txt += key;
      }

  }
  
}


// speak some text
void textToSpeech(String txt) {
  voce.SpeechInterface.synthesize(txt);
}


// stop speaking
void silence() {
   voce.SpeechInterface.stopSynthesizing();
}



// make sure to close things down before we quit
void exit() {
  voce.SpeechInterface.destroy();
  super.exit();
}


// this is a hack to get the library path, needed to configure VOCE.
String getLibraryPath() {
 
    // get the path of the SpeechInterface class
    String libraryPath = voce.SpeechInterface.class.getResource("SpeechInterface.class").toString();
    
    // carefully remove stuff at the beginning and the end
    libraryPath = libraryPath.substring(9, libraryPath.length() - 36);

    // this should return the path to the library
    return libraryPath;
    
}