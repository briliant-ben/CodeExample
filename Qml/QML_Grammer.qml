/* QML Grammar --- Qt 5.12 */
/* 
   To learn how to use it, we can search index below which will hlep us a lot
   > QML Applications
   > First Steps with QML 
   > The QML Reference
   > QML Coding Conventions
*/

/* 
   First 'import' grammar
   > Module (Namespace) Imports
   -- General: import <ModuleIdentifier> <Version.Number> [as <Qualifier>]
   -- import QtQuick 2.0 as Quick
   > Directory Imports
   -- General: import "<DirectoryPath>" [as <Qualifier>]
   -- import "."
   > JavaScript Resource Imports
   -- General: import "<JavaScriptFile>" as <Identifier>
   -- import "chart.js" as chart
   
   QML Import Path
*/

import QtQuick 2.12
import QtQuick.Controls 2.5
import "."

/* 
   QML Object Declarations
   Inside QML Object are these:
   > The id Attribute
   > Property Attributes [ width, height, states, transitions ]
   > Object Properties [ Child Objects ]
   > Signal Attributes
   > Signal Handler Attributes
   > Method Attributes [ JavaScript Functions ]
   > Attached Properties and Attached Signal Handlers [ Component.onCompleted ]
   > Enumeration Attributes
*/

Rectangle {
    id: photo                                               // id on the first line makes it easy to find an object

    property bool thumbnail: false                          // property declarations
    property alias image: photoImage.source

    signal clicked                                          // signal declarations

    function doSomething(x) {                               // javascript functions
	    return x + photoImage.width
    }

    color: "gray"                                           // object properties
    x: 20                                                   // try to group related properties together
    y: 20
    height: 150
    width: {                                                // large bindings
        if (photoImage.width > 200) {
            photoImage.width;
        } else {
		    200;
        }
    }

    Rectangle {                                             // child objects
	    id: border
	    anchors.centerIn: parent; color: "white"
	    Image {
		    id: photoImage
		    anchors.centerIn: parent
	    }
    }

	states: State {                                         // states
		name: "selected"
		PropertyChanges { target: border; color: "red" }
	}

	transitions: Transition {                               // transitions
		from: ""
		to: "selected"
		ColorAnimation { target: border; duration: 200 }
	}
 
/*
   Grouped Properties
   If using multiple properties from a group of properties, consider using group notation instead of dot notation if it improves readability.
   For example, this:
   Rectangle {
	   anchors.left: parent.left; anchors.top: parent.top; anchors.right: parent.right; anchors.leftMargin: 20
	   }
    Text {
      text: "hello"
      font.bold: true; font.italic: true; font.pixelSize: 20; font.capitalization: Font.AllUppercase
    }
    Could be written like this:
*/

	Rectangle {
		anchors { left: parent.left; top: parent.top; right: parent.right; leftMargin: 20 }
	}

	Text {
		text: "hello"
		font { bold: true; italic: true; pixelSize: 20; capitalization: Font.AllUppercase }
	}

/*
	Lists
	If a list contains only one element, we generally omit the square brackets.
	For example, it is very common for a component to only have one state.
	In this case, instead of:
   
	states: [
		State {
			name: "open"
			PropertyChanges { target: container; width: 200 }
		}
	]

	we will write this:
*/

	states: State {
		name: "open"
		PropertyChanges { target: container; width: 200 }
	}
/*
   JavaScript Code
   If the script is a single expression, we recommend writing it inline:

   Rectangle { color: "blue"; width: parent.width / 3 }

   If the script is only a couple of lines long, we generally use a block:
*/
	Rectangle {
		color: "blue"
		width: {
			var w = parent.width / 3
			console.debug(w)
			return w
		}
	}

// If the script is more than a couple of lines long or can be used by different objects, we recommend creating a function and calling it like this:

	function calculateWidth(object){
		var w = object.width / 3
		// ...
		// more javascript code
		// ...
		console.debug(w)
		return w
	}

	Rectangle { color: "blue"; width: calculateWidth(parent) }

/* For long scripts, we will put the functions in their own JavaScript file and import it like this:

  import "myscript.js" as Script

  Rectangle { color: "blue"; width: Script.calculateWidth(parent) }

If the code is longer than one line and hence within a block, we use semicolons to indicate the end of each statement:
*/

	MouseArea {
		anchors.fill: parent
		onClicked: {
			var scenePos = mapToItem(null, mouseX, mouseY);
			console.log("MouseArea was clicked at scene pos " + scenePos);
		}
	}
}
