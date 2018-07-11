#include <iostream>
#include <fstream>
#include <vector>

using std::cout;
using std::cerr;
using std::endl;
using std::ifstream;
using std::vector;

static const uint16_t LOAD_ADDR = 0x2000;

static const uint8_t SOH = 0x01;
static const uint8_t EOT = 0x04;

static uint8_t checksum(vector<uint8_t> const &data) {
    uint8_t sum = 0;
    for (auto const val : data) {
	sum += val;
    }
    return sum;
}

int main(int argc, char const * const argv[]) {
    if (argc < 2) {
	// Just output a "call" packet.
	vector<uint8_t> header;
	header.push_back('C');
	header.push_back(uint8_t(LOAD_ADDR));
	header.push_back(uint8_t(LOAD_ADDR >> 8));
	uint8_t cksum = checksum(header);
	cout << SOH;
	for (auto const byte : header) {
	    cout << byte;
	}
	cout << cksum
	     << EOT;
	return 0;
    }

    // load file
    ifstream file(argv[1], ifstream::in | ifstream::binary);
    if (file.fail()) {
	cerr << "Can't open " << argv[1] << " for input" << endl;
	return 1;
    }

    file.seekg(0, ifstream::end);
    auto fileSize = file.tellg();
    file.seekg(0);

    vector<uint8_t> data(fileSize);
    file.read(reinterpret_cast<char *>(data.data()), data.size());
    if (file.fail()) {
	cerr << "Error reading " << argv[1] << endl;
	return 1;
    }

    uint16_t len = data.size();
    vector<uint8_t> header;
    header.push_back('W');
    header.push_back(uint8_t(LOAD_ADDR));
    header.push_back(uint8_t(LOAD_ADDR >> 8));
    header.push_back(uint8_t(len));
    header.push_back(uint8_t(len >> 8));
    uint8_t cksum = checksum(header) + checksum(data);

    cout << SOH;
    for (auto const byte : header) {
	cout << byte;
    }
    for (auto const byte : data) {
	cout << byte;
    }
    cout << cksum
	 << EOT;

    return 0;
}
