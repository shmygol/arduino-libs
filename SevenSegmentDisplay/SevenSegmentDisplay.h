#include <algorithm>
#include <array>
#include <vector>

#include "Arduino.h"

class SevenSegmentDisplay {
    const std::vector<unsigned char> DIGIT_0 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_1 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_2 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_3 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_4 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_5 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_6 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_7 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_8 = {1, 2, 3, 4, 5, 6};
    const std::vector<unsigned char> DIGIT_9 = {1, 2, 3, 4, 5, 6};
    const std::array<std::vector<unsigned char>, 10> DIGITS = {
        DIGIT_0,
        DIGIT_1,
        DIGIT_2,
        DIGIT_3,
        DIGIT_4,
        DIGIT_5,
        DIGIT_6,
        DIGIT_7,
        DIGIT_8,
        DIGIT_9
    };

    public:
        /**
         *    1
         *  6   2
         *    7
         *  5   3
         *    4   0
         */
        SevenSegmentDisplay(std::array<int, 8> pins, unsigned char segmentShowValue);
        /**
         * Hide a digit from the display. A dot will remain if it's visible
         */
        void hideDigit();
        /**
         * Show given digit on the display
         */
        void showDigit(unsigned char digit);
        /**
         * Hide a dot from the display. A digit will remain if it's visible
         */
        void hideDot();
        /**
         * Show a dot on the display
         */
        void showDot();

    private:
        unsigned char _lastDigit;
        unsigned char _segmentShowValue;
        std::array<int, 8> _pins;
};

