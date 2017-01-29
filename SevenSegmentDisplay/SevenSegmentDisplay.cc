#include "SevenSegmentDisplay.h"

SevenSegmentDisplay::SevenSegmentDisplay(std::array<int, 8> pins, unsigned char segmentShowValue)
{
    _pins = pins;
    _segmentShowValue = segmentShowValue;

    hideDot();
    hideDigit();
}

void SevenSegmentDisplay::hideDigit()
{
    for (unsigned int i=1; i<_pins.size(); ++i) {
        digitalWrite(_pins[i], !_segmentShowValue);
    }
}

void SevenSegmentDisplay::showDigit(unsigned char digit)
{
    std::vector<unsigned char> digitSegments = DIGITS[digit];

    // Set new digit and hide all the segments if the digit was changed
    if(_lastDigit != digit) {
        _lastDigit = digit;
        hideDigit();
    }
    // Iterate over segments for an appropriate digit and show them
    std::for_each(digitSegments.begin(), digitSegments.end(), [this] (unsigned char segmentIndex)
    {
        digitalWrite(_pins[segmentIndex], _segmentShowValue);
    });
}

void SevenSegmentDisplay::hideDot()
{
    digitalWrite(_pins[0], !_segmentShowValue);
}

void SevenSegmentDisplay::showDot()
{
    digitalWrite(_pins[0], !_segmentShowValue);
}

