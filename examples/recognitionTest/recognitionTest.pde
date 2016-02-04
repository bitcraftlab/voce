import voce.*;
import java.net.*;


void setup() {
  
    String libraryPath = getLibraryPath();
    String grammarPath = dataPath("grammar");
    voce.SpeechInterface.init(libraryPath, false, true, grammarPath, "digits");

    println("This is a speech recognition test.");
    println("Speak digits from 0-9 into the microphone.");
    println("Speak 'quit' to quit.");
    
    frameRate(5);
    
}


String getLibraryPath() {
 
    // get the path of the SpeechInterface class
    String libraryPath = voce.SpeechInterface.class.getResource("SpeechInterface.class").toString();
    // carefully remove stuff at the beginning and the end
    libraryPath = libraryPath.substring(9, libraryPath.length() - 36);

    // this should return the path to the library
    return libraryPath;
    
}

void draw() {
  // Let's query the speech to text interface like 5 times a second.
  // we might want ot put this into a seperate thread...
  speechToText();
}


void speechToText() {
  // pop commands
  while (voce.SpeechInterface.getRecognizerQueueSize() > 0) {
    // get a command from the queue
    String cmd = voce.SpeechInterface.popRecognizedString();
    // do something with it
    command(cmd);
  }
}


// process a command
void command(String cmd) {
    // check if the string contains 'quit'.
    if (cmd.indexOf("quit")!= -1) {
      exit();
    } else {
      println("You said: " + cmd);
    } 
}

// make sure to close things down before we quit
void exit() {
  voce.SpeechInterface.destroy();
  super.exit();
}