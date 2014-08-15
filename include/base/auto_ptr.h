// The libMesh Finite Element Library.
// Copyright (C) 2002-2014 Benjamin S. Kirk, John W. Peterson, Roy H. Stogner

// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.

// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.

// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

#ifndef LIBMESH_AUTO_PTR_H
#define LIBMESH_AUTO_PTR_H

#include "libmesh/libmesh_config.h"

// LibMesh's AutoPtr was once equivalent to the (currently deprecated)
// std::auto_ptr, it is now either std::unique_ptr or Howard Hinnant's
// C++03 compatible boost::unique_ptr, depending on your compiler's
// capabilities.

#ifdef HAVE_CXX11_UNIQUE_PTR
#  include <memory>
#  define AutoPtr std::unique_ptr
#else
#  include <boost/unique_ptr.hpp>
#  define AutoPtr boost::unique_ptr
#endif

#endif // LIBMESH_AUTO_PTR_H
