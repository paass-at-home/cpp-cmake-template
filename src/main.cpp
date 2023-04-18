#include <iostream>
#include <SFML/Graphics.hpp>

int main(int argc, char* args[]) {
    // create a new window of size wWidth * wHeight pixels
    // top-left of the windows is (0,0) and bottom-right is (wWidth, wHeight)
    const int wWidth = 800;
    const int wHeight = 600;
    sf::RenderWindow window(sf::VideoMode(wWidth, wHeight), "SFML works!");
    window.setFramerateLimit(60);

    // main loop - continues for each frame while window is open
    while (window.isOpen()) {
        sf::Event event;
        while (window.pollEvent(event)) {
            // this event triggers when the window is closed
            if (event.type == sf::Event::Closed) {
                window.close();
            }

            // this event is triggered when a key is pressed
            if (event.type == sf::Event::KeyPressed) {
                std::cout << "Key pressed with code = " << event.key.code << std::endl;
            }
        }

        // basic rendering function calls        
        window.clear();       // clear the windows of anything previously drawn

        // render eveything
        // window.draw( ... );

        window.display();     // call the window display function
    }
    return 0;
}
