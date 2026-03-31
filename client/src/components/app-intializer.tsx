import apiClient from '@/service/api-client';
import { logout, setLoading, setSession } from '@/store/features/auth/authSlice';
import type { ApiResponse } from '@/types/api';
import { useEffect, type ReactNode } from 'react';
import { useDispatch } from 'react-redux';

const AppInitializer = ({ children }: { children: ReactNode }) => {
    const dispatch = useDispatch()
    useEffect(() => {
        const refresh = async () => {

            try {
                const { data } = await apiClient.post<ApiResponse<{ user: any, accessToken: string }>>("/auth/refresh-token", {}, { withCredentials: true });
                const accessToken = data?.content?.accessToken ?? null;
                const user = data.content.user
                if (!accessToken) throw new Error("Refresh token response missing accessToken");
                dispatch(setSession({ user, accessToken }))
            } catch (error) {
                console.error(error)
                dispatch(logout())
            } finally {
                dispatch(setLoading(false))
            }
        }

        refresh()
    }, [])


    return <>{children}</>
}
export default AppInitializer