CXX      := g++
CXXFLAGS := -std="c++11"
LDFLAGS  := -lstdc++ -lm -lLiDIA -lgmp -lcryptopp
BUILD    := ./build
LIB      := ./include
SRC      := ./src
OBJ_DIR  := $(BUILD)/objects
APP_DIR  := $(BUILD)/apps
TARGET   := main
INCLUDE  := -Iinclude/ -isystem/usr/local/include
OBJECTS  := $(patsubst ./src/%.cc,$(OBJ_DIR)/%.o,$(wildcard $(SRC)/*.cc))

.PHONY: all clean debug release

all: $(APP_DIR)/$(TARGET)

$(OBJ_DIR)/%.o: $(SRC)/%.cc
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

$(APP_DIR)/$(TARGET): $(OBJECTS)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(INCLUDE) $(LDFLAGS) -o $(APP_DIR)/$(TARGET) $(OBJECTS)

$(OBJ_DIR)/main.o: $(addprefix $(LIB)/,gps.h walker.h step.h order.h basis.h extension.h)
$(OBJ_DIR)/gps.o: $(addprefix $(LIB)/,gps.h walker.h step.h order.h basis.h extension.h)
$(OBJ_DIR)/walker.o: $(addprefix $(LIB)/,walker.h modular.h step.h order.h basis.h extension.h)
$(OBJ_DIR)/order.o: $(addprefix $(LIB)/,order.h step.h basis.h extension.h)
$(OBJ_DIR)/step.o: $(addprefix $(LIB)/,step.h extension.h)
$(OBJ_DIR)/basis.o: $(addprefix $(LIB)/,basis.h extension.h)
$(OBJ_DIR)/extension.o: $(addprefix $(LIB)/,extension.h)

debug: CXXFLAGS += -DDEBUG -g3 -O0
debug: all

release: CXXFLAGS += -O2
release: all

clean:
	-@rm -rvf $(OBJ_DIR)/*
	-@rm -rvf $(APP_DIR)/*
