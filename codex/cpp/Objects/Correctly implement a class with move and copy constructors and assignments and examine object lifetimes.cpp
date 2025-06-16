// cpp, object lifetimes, constructors, destructors, safety, copy constructors, move contructors, copy assignment, move assignment, vector, push_back, emplace_back, move, operator overloading, << overloading, heap, templates, new, delete, friend

#include <iostream>
#include <vector>

/**
 * This is a pedagogical example...
 *
 * It's meant to demonstrate
 *   - object lifetimes
 *   - the rule of 5
 *   - safely using copy and move constructors/assignment
 *
 * The class implements a wrapper (box) around a type templated
 * allocated on the heap
 *
 */

template<typename T>
struct Box {

    /**
     * Constructors
     */
    Box(T _contents) {
        contents = new T;
        *contents = _contents;
        std::cout << "\nConstructed a box:\n" << *this;
    }

    Box() {
        contents = new T {};
        std::cout << "\nConstructed a box:\n" << *this;
    }

    /* Copy constructor */
    Box(const Box& other) {
        /*
         * if the implementation was the following:
         *
         * contents = other.contents;
         *
         * that would be bad
         */
        contents = new T;
        *contents = *other.contents;
        std::cout << "\nCopy-constructed a box:\n" << *this;
    }

    /* Move constructor */
    Box(Box&& other) noexcept {
        contents = other.contents;
        other.contents = nullptr;
        std::cout << "\n Move-constructed a box:\n" << *this;
    }

    /**
     * Assignment operator overloads
     */

    /* Copy assignment */
    Box& operator=(const Box& other) {
        if (this == &other) return *this;
        /*
         * the following is ok
         *
         * const auto newContent = new T;
         * *newContent = *other.contents;
         *
         * but it'll leak memory if it throws
         *
         * better like this
         */
        const auto newContent = new T(*other.contents);  // may throw
        delete contents;    // it will leak if we don't delete current contents
        contents = newContent;
        /* this way, this->contents is still valid even if it throws */
        std::cout << "\n Copy-assigned a box:\n" << *this;
        return *this;
    }

    /* Move assignment */
    Box& operator=(Box&& other) noexcept {
        if (this == &other) return *this;
        delete contents;
        contents = other.contents;
        /* 
         * printing here _before_ null-ing other.contents 
         * in case *this and other are the same
         */
        std::cout << "\n Move-assigned a box:\n" << *this;
        other.contents = nullptr;
        return *this;
    }

    /**
     * Destructor
     */
    ~Box() {
        std::cout << "\nDestoying a box:\n" << *this;
        delete contents;
        contents = nullptr;
    }

    /* this is a non-member function
     * `friend` means it can access private variables
     */
    friend std::ostream& operator<<(std::ostream& outstream, const Box<T>& box) {
        outstream << "  address: [" << &box << "]\n";
        if (box.contents) 
            outstream << "  content address: [" << box.contents << "] " << *box.contents << "\n";
        else
            outstream << "  (box contents are null)\n";
        return outstream;
    }

  private:
    T* contents;
};


void demoConstructionAssignmentEtc() {

    /* regular constructor */
    Box<int> b1 { 5 };
    /*
    Constructed a box:
      address: [0x16b5e2238]
      content address: [0x6000001dc040] 5
    */

    /* copy constructor */
    Box<int> b2 { b1 };
    /*
    Copy-constructed a box:
      address: [0x16b5e2230]
      content address: [0x6000001dc050] 5
    */

    /* move constructor */
    Box<int> b3 { std::move(b1) };
    /*
     Move-constructed a box:
      address: [0x16b5e2228]
      content address: [0x6000001dc040] 5
    */

    /*
     * default constructor
     * and then copy assignment
     */
    Box<int> b4;
    b4 = b2;
    /*
    Constructed a box:
      address: [0x16b5e2220]
      content address: [0x6000001dc060] 0

     Copy-assigned a box:
      address: [0x16b5e2220]
      content address: [0x6000001dc070] 5
    */

    Box<int> b5;
    b5 = std::move(b3);
    /*
    Constructed a box:
      address: [0x16b5e2218]
      content address: [0x6000001dc060] 0

     Move-assigned a box:
      address: [0x16b5e2218]
      content address: [0x6000001dc040] 5
    */

    std::cout << "\n---\n";

    /*
    Destoying a box:
      address: [0x16b5e2218]
      content address: [0x6000001dc040] 5

    Destoying a box:
      address: [0x16b5e2220]
      content address: [0x6000001dc070] 5

    Destoying a box:
      address: [0x16b5e2228]
      (box contents are null)

    Destoying a box:
      address: [0x16b5e2230]
      content address: [0x6000001dc050] 5

    Destoying a box:
      address: [0x16b5e2238]
      (box contents are null)
    */
}


void demoWithVectors () {
    Box<int> b1 { 1 };
    Box<int> b2 { 2 };

    std::vector<Box<int>> myBoxes { };
    myBoxes.reserve(10);
    /*
     * if I didn't use `reserve`, the vector might have to re-alloc.
     * If it did, it would have to _move_ all the elements to the
     * new memory locations.
     * Luckily--because the move constructor is `noexcept`, std::vector
     * knows it's safe to move (and not copy) the elements over
     */

    /* this will make a copy of b1 */
    myBoxes.push_back(b1);

    /* this will make a copy of b1 */
    myBoxes.push_back(std::move(b2));

    /* builds a new box in place */
    myBoxes.emplace_back(3);
}


int main() {
    demoConstructionAssignmentEtc();
    demoWithVectors();
}


