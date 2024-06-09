#ifndef BASE_TYPES_CASTING_H_
#define BASE_TYPES_CASTING_H_
#include <type_traits>
namespace base {

template <typename to, typename from>
auto _static_cast(from *val, typename std::enable_if_t<std::is_polymorphic_v<std::remove_pointer_t<to>> && std::is_polymorphic_v<from>>* = 0) {
  return dynamic_cast<to>(val);
}

template <typename to, typename from>
auto _static_cast(from *val, typename std::enable_if_t<!std::is_polymorphic_v<std::remove_pointer_t<to>> || !std::is_polymorphic_v<from>>* = 0) {
  return static_cast<to>(val);
}

template <typename to, typename from>
constexpr decltype(auto) _static_cast(const from &val) {
  return static_cast<to>(val);
}

template <typename to, typename from>
constexpr decltype(auto) _static_cast(from &val) {
  return static_cast<to>(val);
}

}

#endif // BASE_TYPES_CASTING_H_
