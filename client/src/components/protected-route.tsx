import { useSelector } from "react-redux";
import type { RootState } from "@/store/store";
import { Navigate, Outlet, } from "react-router";
import ErrorBoundary from "./error-boundary";
import { Loader2 } from "lucide-react";

const ProtectedRoute = () => {
  const { isAuthenticated, isLoading } = useSelector((state: RootState) => state.auth)




  if (isLoading) {
    return <div className="h-screen w-full flex justify-center items-center bg-background">
      <Loader2 className="animate-spin" />
    </div>
  }

  if (!isAuthenticated) {
    return <Navigate to={'/login'} replace />
  }

  return <ErrorBoundary><Outlet /></ErrorBoundary>
}

export default ProtectedRoute;