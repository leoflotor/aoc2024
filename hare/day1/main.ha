use fmt;
use bufio;
use strings;
use os;
use io;
use strconv;
use sort;
use math;

export fn main() void = {
	const file = os::open("../../inputs/day1/input.txt")!;
	defer io::close(file)!;

	// Arrays for columns and default column separator
	let left: []int = [];
	let right: []int = [];
	let sep: str = "   ";
	let line_count: uint = 0;

	for (true) {
		// Read lines as slices of bytes
		const line = match (bufio::read_line(file)!) {
		case io::EOF =>
			break;
		case let line: []u8 =>
			yield line;
		};

		// Divide lines into its two columns
		let left_right: (str, str) = strings::cut(strings::fromutf8(line)!, sep);
		append(left, strconv::stoi(left_right.0)!);
		append(right, strconv::stoi(left_right.1)!);
		line_count += 1;
	};

	// Sort both lists
	sort::sort(left, size(int), &cmp_ints);
	sort::sort(right, size(int), &cmp_ints);

	// Solve both parts
	part1(left, right);
	part2(left, right);
};

fn cmp_ints(a: const *opaque, b: const *opaque) int = {
	const a = *(a: const *int); // why?
	const b = *(b: const *int);
	return if (a < b) -1
		else if (a > b) 1
		else 0;
};

fn distance(a: int, b: int) uint = {
	return math::absi(a - b);
};

fn part1(left: []int, right: []int) void = {
	let acc: uint = 0;
	let i = 0z;
	for (i < len(left); i += 1) {
		acc += distance(left[i], right[i]);
	};
	fmt::printfln("{}", acc)!;
};

fn part2(left: []int, right: []int) void = {
	let i = 0z; // keep track of the indexes
	let j = 0z;
	let n: uint = 0; // count the occurrences
	let m: uint = 0;
	let c: int = left[i]; // keep track of the current number
	let acc: uint = 0;
	for (true) {
		if (left[i] < right[j]) {
			if (m != 0) {
				n += 1;
			};
			i += 1;
		} else if (left[i] == right[j]) {
			j += 1;
			m += 1;
		} else {
			j += 1;
		};
		if (i >= len(left) || j >= len(right)) {
			acc += (c: uint) * m * n;
			break;
		};
		if (c != left[i]) {
			acc += (c: uint) * m * n;
			c = left[i];
			n = 0;
			m = 0;
		};
	};
	fmt::println(acc)!;
};
