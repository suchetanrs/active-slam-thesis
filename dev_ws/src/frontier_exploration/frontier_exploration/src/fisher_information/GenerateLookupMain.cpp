
#include <iostream>
#include "frontier_exploration/fisher_information/FisherInfoManager.hpp"
#include "frontier_exploration/Parameters.hpp"

int main(int argc, char** argv) {
    frontier_exploration::FisherInformationManager fim_manager;
    try {
        fim_manager.generateLookupTable(0.0, 21.0, -8.5  * 1.732, 8.5  * 1.732, -8.5  * 1.732, 8.5  * 1.732);
        // fim_manager.generateLookupTable(0.0, 3.5, -3.0, 3.0, -3.0, 3.0);
        // fim_manager.generateLookupTable(0.0, 2.1 * 2, -2.1 * 2, 2.1 * 2, -2.1 * 2, 2.1 * 2);
        std::cout << "Lookup table generated successfully." << std::endl;
    } catch (const std::exception& e) {
        std::cerr << "Error generating lookup table: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
