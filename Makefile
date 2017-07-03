IMAGE_NAME := justinian/wk-image-updater

SRCS := $(wildcard src/*.cpp)
OBJS := $(SRCS:.cpp=.o) 

LDFLAGS := -lcurl -ljsoncpp -lpng -lfreetype -lboost_program_options
CXXFLAGS := -MD -MP -I/usr/include/freetype2

wanikaniwallpaper: ${OBJS}
	g++ ${OBJS} ${LDFLAGS} -o $@

-include $(OBJS:.o=.d)

src/%.o: src/%.cpp

docker_image: Dockerfile wanikaniwallpaper
	docker build --rm -t ${IMAGE_NAME} .
