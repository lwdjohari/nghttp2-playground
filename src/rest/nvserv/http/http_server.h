#include <memory>
#include <string>
#include <cstdint>
#include <thread>
#include "nvserv/global.h"


NVSERV_BEGIN_NAMESPACE(nvserv::http)

class HttpServer{
    public:
        explicit HttpServer();
        ~HttpServer();
};

NVSERV_END_NAMESPACE